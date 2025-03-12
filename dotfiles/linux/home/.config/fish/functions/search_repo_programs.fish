function search_repo_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword in the repositories"
    if test -z "$program_keyword"
        echo "You need to provide a keyword to search for! e.g., search_repo_programs kubuntu"
    else
        nala search $program_keyword | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | grep $program_keyword | awk '{print $1}'
    end
end
