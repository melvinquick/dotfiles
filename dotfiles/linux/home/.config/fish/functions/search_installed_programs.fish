function search_installed_programs -a program_keyword -d "Pass a keyword to find any programs containing that keyword installed on your system"
    nala search $program_keyword -i | grep $program_keyword | awk '{print $1}'
end
