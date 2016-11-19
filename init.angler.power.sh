#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

function get-set-forall() {
    for f in $1 ; do
        cat $f
        write $f $2
    done
}

################################################################################

# disable thermal bcl hotplug to switch governor
write /sys/module/msm_thermal/core_control/enabled 0
get-set-forall /sys/devices/soc.0/qcom,bcl.*/mode disable
bcl_hotplug_mask=`get-set-forall /sys/devices/soc.0/qcom,bcl.*/hotplug_mask 0`
bcl_hotplug_soc_mask=`get-set-forall /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask 0`
get-set-forall /sys/devices/soc.0/qcom,bcl.*/mode enable

# some files in /sys/devices/system/cpu are created after the restorecon of
# /sys/. These files receive the default label "sysfs".
# Restorecon again to give new files the correct label.
restorecon -R /sys/devices/system/cpu

# ensure at most one A57 is online when thermal hotplug is disabled
write /sys/devices/system/cpu/cpu5/online 0
write /sys/devices/system/cpu/cpu6/online 0
write /sys/devices/system/cpu/cpu7/online 0

# Best effort limiting for first time boot if msm_performance module is absent
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 960000

# Limit A57 max freq from msm_perf module in case CPU 4 is offline
write /sys/module/msm_performance/parameters/cpu_max_freq "4:960000 5:960000 6:960000 7:960000"

# Stock frequencies and interactive governor
# The user can overclock if they want but it is a little more stable to use these frequencies
# Little cluster governor - interactve
chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive
# Little cluster min - 302 MHz
chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 302400
# Little cluster max - 1555 MHz
chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1555200
# Big cluster governor - interactve 
chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor interactive
# Big cluster min - 633 MHz
chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 633600
# Big cluster max - 1958 MHz
chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1958400

# Little cluster settings settings by: Flash 1.0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 99
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay "20000 1344000:40000"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 768000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack -1
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "60 384000:50 460800:50 600000:55 672000:60 768000:60 864000:55 960000:90 1248000:90 1344000:80 1478000:90 1555200:99"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 60000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis 80000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration 0


# online CPU4
write /sys/devices/system/cpu/cpu4/online 1

# Big cluster settings settings by: Flash 1.0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 95
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "40000 960000:60000 1728000:20000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 633600
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack -1
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "95 633600:80 768000:85 864000:90 960000:90 1248000:95 1344000:95 1444000:95 1536000:95 1632000:95 1728000:98 1824000:99 1958000:100"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 80000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration 0

# plugin remaining A57s
write /sys/devices/system/cpu/cpu5/online 1
write /sys/devices/system/cpu/cpu6/online 1
write /sys/devices/system/cpu/cpu7/online 1

# Restore CPU 4 max freq from msm_performance
write /sys/module/msm_performance/parameters/cpu_max_freq "4:4294967295 5:4294967295 6:4294967295 7:4294967295"

# Input boost settings
write /sys/module/cpu_boost/parameters/input_boost_enabled 1
write /sys/module/cpu_boost/parameters/input_boost_freq "0:1248000 1:1248000 2:1248000 3:1248000 4:0 5:0 6:0 7:0"
write /sys/module/cpu_boost/parameters/boost_ms 0
write /sys/module/cpu_boost/parameters/input_boost_ms 50

# Readahead configuration
write /sys/block/mmcblk0/bdi/read_ahead_kb 128

# Wakelock dividers
# This will help with disconnects on poorly configured 5GHz networks
write /sys/module/bcmdhd/parameters/wlrx_divide 8
write /sys/module/bcmdhd/parameters/wlctrl_divide 8

# re-enable retention idle state
# fix-up is merged in the Kernel
write /sys/module/lpm_levels/system/a53/cpu0/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a53/cpu1/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a53/cpu2/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a53/cpu3/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a57/cpu4/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a57/cpu5/retention/idle_enabled 1
write /sys/module/lpm_levels/system/a53/a53-l2-retention/idle_enabled 1
write /sys/module/lpm_levels/system/a57/a57-l2-retention/idle_enabled 1

# bcmdhd wakeup sources
write /sys/module/wakeup/parameters/enable_wlan_rx_wake_ws 0
write /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_ws 0
write /sys/module/wakeup/parameters/enable_wlan_wake_ws 0

# Setting B.L scheduler parameters
write /proc/sys/kernel/sched_migration_fixup 1
write /proc/sys/kernel/sched_upmigrate 95
write /proc/sys/kernel/sched_downmigrate 85
write /proc/sys/kernel/sched_freq_inc_notify 400000
write /proc/sys/kernel/sched_freq_dec_notify 400000

# android background processes are set to nice 10. Never schedule these on the a57s.
write /proc/sys/kernel/sched_upmigrate_min_nice 9

# devfreq
get-set-forall /sys/class/devfreq/qcom,cpubw*/governor bw_hwmon
restorecon -R /sys/class/devfreq/qcom,cpubw*
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/sample_ms 4
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hist_memory 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hyst_length 10
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_ceil_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_delay 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/guard_band_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/up_scale 250
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/idle_mbps 1600
get-set-forall /sys/class/devfreq/qcom,mincpubw*/governor cpufreq

# Disable sched_boost
write /proc/sys/kernel/sched_boost 0

# re-enable thermal and BCL hotplug
write /sys/module/msm_thermal/core_control/enabled 1
get-set-forall /sys/devices/soc.0/qcom,bcl.*/mode disable
get-set-forall /sys/devices/soc.0/qcom,bcl.*/hotplug_mask $bcl_hotplug_mask
get-set-forall /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask $bcl_hotplug_soc_mask
get-set-forall /sys/devices/soc.0/qcom,bcl.*/mode enable

# change GPU initial power level from 305MHz(level 4) to 180MHz(level 5) for power savings
write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
