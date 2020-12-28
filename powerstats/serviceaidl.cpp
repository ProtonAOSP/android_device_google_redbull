/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.power.stats-service.pixel"

#include <PowerStatsAidl.h>
#include <dataproviders/IioEnergyMeterDataProvider.h>
#include <dataproviders/DisplayStateResidencyDataProvider.h>
#include <dataproviders/PowerStatsEnergyConsumer.h>

#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <log/log.h>

using aidl::android::hardware::power::stats::EnergyConsumerId;
using aidl::android::hardware::power::stats::IioEnergyMeterDataProvider;
using aidl::android::hardware::power::stats::PowerStats;
using aidl::android::hardware::power::stats::PowerStatsEnergyConsumer;
using aidl::android::hardware::power::stats::DisplayStateResidencyDataProvider;

void addDisplayStats(std::shared_ptr<PowerStats> p) {
    android::sp<DisplayStateResidencyDataProvider> displaySdp =
        new DisplayStateResidencyDataProvider("Display",
            "/sys/class/backlight/panel0-backlight/state",
            {"Off", "LP", "1080x2340@60", "1080x2340@90"});
    p->addStateResidencyDataProvider(displaySdp);
}

void addDisplayEnergyConsumer(std::shared_ptr<PowerStats> p) {
    android::sp<PowerStatsEnergyConsumer> displayConsumer;

    displayConsumer = PowerStatsEnergyConsumer::createMeterAndEntityConsumer(p,
            EnergyConsumerId::DISPLAY, {"PPVAR_VPH_PWR_OLED"}, "Display",
            {{"LP", 41},
             {"1080x2340@60", 124},
             {"1080x2340@90", 162}});

    if (!displayConsumer) {
        displayConsumer = PowerStatsEnergyConsumer::createMeterAndEntityConsumer(p,
            EnergyConsumerId::DISPLAY, {"VPH_PWR_AMOLED"}, "Display",
            {{"LP", 33},
             {"1080x2340@60", 106}});
    }

    p->addEnergyConsumer(displayConsumer);
}

void setEnergyMeter(std::shared_ptr<PowerStats> p) {
    std::vector<const std::string> deviceNames { "microchip,pac1934" };
    p->setEnergyMeterDataProvider(
        std::make_unique<IioEnergyMeterDataProvider>(deviceNames));
}

int main() {
    LOG(INFO) << "Pixel PowerStats HAL AIDL Service is starting.";

    // single thread
    ABinderProcess_setThreadPoolMaxThreadCount(0);

    std::shared_ptr<PowerStats> p = ndk::SharedRefBase::make<PowerStats>();
    if (!p) {
        return EXIT_FAILURE;
    }

    setEnergyMeter(p);
    addDisplayStats(p);
    addDisplayEnergyConsumer(p); // Must be done after setEnergyMeter() and addDisplayStats()

    const std::string instance = std::string() + PowerStats::descriptor + "/default";
    binder_status_t status = AServiceManager_addService(p->asBinder().get(), instance.c_str());
    LOG_ALWAYS_FATAL_IF(status != STATUS_OK);

    ABinderProcess_joinThreadPool();
    return EXIT_FAILURE;  // should not reach
}
