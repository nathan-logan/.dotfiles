function infer_branch_ticket
    set branch_name $argv[1]
    set ticket (string match -r "(?:PKB)-[^-]*" $branch_name)
    echo $ticket
end
