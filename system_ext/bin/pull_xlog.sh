#!/system/bin/sh

xlog="/data/data/com.tencent.mm/files/xlog/"
logpath=`getprop persist.sys.oemlog.path`
oem_log=""
current_log=""

if [ "$logpath" == "data" ]; then
    oem_log="/data/oem_log"
elif [ "$logpath" == "sdcard" ]; then
    oem_log="/sdcard/Android/data/oem_log"
else
    oem_log="/sdcard/Android/data/oem_log"
fi

if [ -d $xlog ]; then
    if [ -d $oem_log ]; then
        dir=`ls -al $oem_log`
        for filename in $dir
        do
            match=`echo $filename | grep "_current"`
            if [ -n "$match" ]; then
                current_log="$filename"
                break
            fi
        done
        if [ -n "$current_log" ]; then
            oem_xlog="${oem_log}/${current_log}/xlog"
        else
            log -p i -t pull_xlog "current_log directory does not exist"
            oem_xlog="${oem_log}/xlog"
        fi
    else
        log -p i -t pull_xlog "oem_log does not exist"
        oem_xlog="${oem_log}/xlog"
    fi

    if [ ! -d "$oem_xlog" ]; then
        mkdir -p $oem_xlog
        cp -rf $xlog $oem_xlog
        chmod 777 -R ${oem_xlog}
    fi

else
    log -p i -t pull_xlog "xlog does not exist"
fi

