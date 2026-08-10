# A function which filters options which starts with "-" from $argv.
function _swift_tp_preprocessor
    set -l results
    for i in (seq (count $argv))
        switch (echo $argv[$i] | string sub -l 1)
            case '-'
            case '*'
                echo $argv[$i]
        end
    end
end

function _swift_tp_using_command
    set -l currentCommands (_swift_tp_preprocessor (commandline -opc))
    set -l expectedCommands (string split " " $argv[1])
    set -l subcommands (string split " " $argv[2])
    if [ (count $currentCommands) -ge (count $expectedCommands) ]
        for i in (seq (count $expectedCommands))
            if [ $currentCommands[$i] != $expectedCommands[$i] ]
                return 1
            end
        end
        if [ (count $currentCommands) -eq (count $expectedCommands) ]
            return 0
        end
        if [ (count $subcommands) -gt 1 ]
            for i in (seq (count $subcommands))
                if [ $currentCommands[(math (count $expectedCommands) + 1)] = $subcommands[$i] ]
                    return 1
                end
            end
        end
        return 0
    end
    return 1
end

complete -c tp -n '_swift_tp_using_command "tp reset-enrollment"' -l data-dir -d 'Path to Teleport\'s data directory.'
complete -c tp -n '_swift_tp_using_command "tp reset-enrollment"' -s h -l help -d 'Show help information.'
complete -c tp -n '_swift_tp_using_command "tp" "reset-enrollment help"' -l data-dir -d 'Path to Teleport\'s data directory.'
complete -c tp -n '_swift_tp_using_command "tp" "reset-enrollment help"' -s h -l help -d 'Show help information.'
complete -c tp -n '_swift_tp_using_command "tp" "reset-enrollment help"' -f -a 'reset-enrollment' -d 'Remove pending mobile-device enrollment pairings from a local Teleport cluster'
complete -c tp -n '_swift_tp_using_command "tp" "reset-enrollment help"' -f -a 'help' -d 'Show subcommand help information.'
