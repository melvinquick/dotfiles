function search_installed_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword installed on your system"
    if test -z "$program_keyword"
        echo "You need to provide a keyword to search for! e.g., search_installed_programs kubuntu"
    else
        nala search $program_keyword -i | grep 'is installed$' -B 1 | grep -v 'is installed$' | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | grep "$program_keyword" | awk '{print $1}'
    end
end
