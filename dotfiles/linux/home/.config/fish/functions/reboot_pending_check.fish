function reboot_pending_check -a verbose -d "This will check to see if the kernel version that's active is the current version on the system"
    if test -z $verbose
        set $verbose false
    else
        set $verbose true
    end

    set active_kernel (uname -r | sed 's/\./-/g')
    set current_kernel (sip kernel | grep "linux " | awk '{print $2}' | sed 's/\./-/g')

    if test $active_kernel != $current_kernel
        echo "REBOOT REQUIRED"
        if test $verbose
            echo "Active Kernel: $active_kernel"
            echo "Current Kernel: $current_kernel"
        end
    else
        echo "REBOOT NOT REQUIRED"
        if test $verbose
            echo "Active Kernel: $active_kernel"
        end
    end
end
