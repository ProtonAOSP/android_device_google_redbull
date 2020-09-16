#!/vendor/bin/sh

# Implementation of A/B group selection - See b/161398758
seedfile=/sys/devices/platform/soc/soc:qcom,dsi-display-primary/panel_info/panel0/serial_number

# Poll the file for up to 30 seconds
retries=30
while [[ ! "$(cat $seedfile)" ]]; do
    retries=$(($retries - 1))
    if [[ $retries == 0 ]]; then
        setprop vendor.twoshay.study_group "failed"
        exit
    fi

    sleep 1
done

sum=$(sha1sum $seedfile)
result=$(expr $((16#${sum:1:1})) % 2)

setprop vendor.twoshay.study_group $result
