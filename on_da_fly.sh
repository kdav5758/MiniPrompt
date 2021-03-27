#!/bin/bash

# ODF stands for "On Da Fly" (yes, this was on purpose becuase OTF for "On The Fly" already stands for a file format for fonts)

# skip_init=false

# # main functionalities
# ssh_prompt=true
# my_bin=false
# add_exit=true

# # extensions
# extensions_main=false
# GIT_PROMPT=true
# KUBE_PROMPT=false

this_scrpt=`basename "$0"`
script_help=$( cat << EOF

This script simplifies the process of changing MiniPrompt's configuration variables
on the fly for the current terminal session

Usage:
    #0: ${this_scrpt} [arg] <modifier(s)>
    #1: ${this_scrpt} [flag]
Arguments:
    ex, exe,extensions,extensions_main              Modify 'extensions_main' var
    gp, git,git_prompt,GIT_PROMPT                   Modify 'GIT_PROMPT' var
    kb, kube,kubernetes_prompt,KUBE_PROMPT          Modify 'KUBE_PROMPT' var
    mb, b,my_bin,MY_BIN                             Modify 'MY_BIN' var
    ae, add_exit,ADD_EXIT                           Modify 'add_exit' var
    si, skip_init,SKIP_INIT                         Modify 'skip_init' var
Modifiers: (only for arguments)
    f/false/FALSE                                   Disables [arg]
    t/true/TRUE                                     Enables [arg]
Flags:
    -h,--help                                       See this help message.
    -d, -dis,-disable,-DISABLE                      Disable MiniPrompt

Examples:
    #0: $this_scrpt gp t
        Explanation: This will export the 'GIT_PROMPT' variable as true (enables it to show branch on prompt)
    #1: $this_scrpt ex f
        Explanation: This will export the 'extensions_main' variable as false (disables all extensions)
    #2: $this_scrpt ae t
        Explanation: This will export the 'add_exit' variable as true (enables exit status to be shown on prompt)

EOF
)


function boolean_toggle() {
    to_test=$1

    if [[ "$to_test" == "t" ]] || [[ "$to_test" == "true" ]] || [[ "$to_test" == "TRUE" ]]; then
        toggle=true
    elif [[ "$to_test" == "false" ]] || [[ "$to_test" == "f" ]] || [[ "$to_test" == "FALSE" ]]; then
        toggle=false
    else
        echo -e "Argument number 2 was set to '$to_test', and it can only be one of the following ones: t/f/true/false"
    fi
}

if [[ -n "$1" ]]; then
    case "$1" in
        "ex"|"exe"|"extensions"|"extensions_main")
            toggle=$2
            boolean_toggle $toggle
            export extensions_main=$toggle
            ;;
        "gp"|"git"|"git_prompt"|"GIT_PROMPT")
            toggle=$2
            boolean_toggle $toggle
            export GIT_PROMPT=$toggle
            ;;
        "kb"|"kube"|"kubernetes_prompt"|"KUBE_PROMPT")
            toggle=$2
            boolean_toggle $toggle
            export KUBE_PROMPT=$toggle
            ;;
        "sp"|"ssh"|"ssh_prompt"|"SSH_PROMPT")
            toggle=$2
            boolean_toggle $toggle
            export ssh_prompt=$toggle
            ;;
        "mb"|"b"|"my_bin"|"MY_BIN")
            toggle=$2
            boolean_toggle $toggle
            export my_bin=$toggle
            ;;
        "ae"|"add_exit"|"ADD_EXIT")
            toggle=$2
            boolean_toggle $toggle
            export add_exit=$toggle
            ;;
        "si"|"skip_init"|"SKIP_INIT")
            toggle=$2
            boolean_toggle $toggle
            export skip_init=$toggle
            ;;
        "-en"|"-ena"|"-enable"|"-ENABLE")
            toggle=$2
            boolean_toggle $toggle
            export MINIPROMPT_ENABLED=$toggle
            ;;
        "-h"|"--help")
            echo "$script_help"
            # exit 0    # causes shell to close
            ;;
        *)
            echo "command was not recognized"
            ;;
    esac
else
    echo -e "This script needs at least one argument to work.\nType '$this_scrpt -h' or '$this_scrpt --help' for help "
fi

