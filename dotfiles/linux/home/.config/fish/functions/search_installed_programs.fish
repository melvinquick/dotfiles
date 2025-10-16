function search_installed_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword installed on your system"
    if test -z "$program_keyword"
        echo "You need to provide a keyword to search for! e.g., search_installed_programs fish"
    else
        yay -Qs $program_keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/

        set found_programs (yay -Qs $program_keyword)
        if test -z "$found_programs"
            echo "No programs found on the system containing the keyword '$program_keyword'"
        end
    end
end
