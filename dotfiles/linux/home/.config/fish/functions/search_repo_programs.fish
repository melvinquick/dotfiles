function search_repo_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword in the repositories"
    nala search $program_keyword | grep $program_keyword | awk '{print $1}'
end
