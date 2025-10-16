function search_repo_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword in the repositories"
    if test -z "$program_keyword"
        echo "You need to provide a keyword to search for! e.g., search_repo_programs fish"
    else
        yay -Ss $program_keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/

        set found_programs (yay -Ss $program_keyword)
        if test -z "$found_programs"
            echo "No programs found in the Standard Repositories, Chaotic AUR, or AUR containing the keyword '$program_keyword'"
        end
    end
end
