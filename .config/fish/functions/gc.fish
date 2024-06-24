function gc
    # get the ticket number using the current branch name, e.g PKB-5366
    set ticket (git rev-parse --abbrev-ref HEAD | string match -r "(?:PKB)-[^-]*")

    set branch_type $argv[1]
    set commit_message $argv[2]

    if test -z "$branch_type"
        echo "Invalid format. Missing branch type. Valid format is: gc [branch_type] [commit_message]"
        return 1
    end

    if test -z "$commit_message"
        echo "Invalid format. Missing commit message. Valid format is: gc [branch_type] [commit_message]"
        return 1
    end

    # test if we have a ticket number, if so prefix with the ticket number
    if test -n "$ticket"
        git commit -m "$branch_type($ticket): $commit_message" -e
    else
        git commit -m "$branch_type: $commit_message" -e
    end
end
