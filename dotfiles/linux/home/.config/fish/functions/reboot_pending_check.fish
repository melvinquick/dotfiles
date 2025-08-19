function reboot_pending_check
    set active_kernel (uname -r | sed 's/\./-/g')
    set current_kernel (sip kernel | grep "linux " | awk '{print $2}' | sed 's/\./-/g')
    if test $active_kernel != $current_kernel
        echo "REBOOT REQUIRED"
        echo
        read -P "Would you like to see the active and current kernel versions (y/n)?: " user_input
        if test $user_input = y
            echo \n"Active Kernel: $active_kernel"
            echo "Current Kernel: $current_kernel"
        end
    else
        echo "REBOOT NOT REQUIRED"
        read -P "Would you like to see the active kernel version (y/n)?: " user_input
        if test $user_input = y
            echo \n"Active Kernel: $active_kernel"
        end
    end
end
