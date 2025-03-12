function search_repo_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword in the repositories"
    if test -z "$program_keyword"
        nala search | awk '{print $1}'
    else
        nala search $program_keyword | grep $program_keyword | awk '{print $1}'
    end
end
