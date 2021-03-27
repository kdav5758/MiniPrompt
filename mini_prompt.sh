#!/bin/bash

 # __  __ _       _ _____                           _
# |  \/  (_)     (_)  __ \                         | |
# | \  / |_ _ __  _| |__) | __ ___  _ __ ___  _ __ | |_
# | |\/| | | '_ \| |  ___/ '__/ _ \| '_ ` _ \| '_ \| __|
# | |  | | | | | | | |   | | | (_) | | | | | | |_) | |_
# |_|  |_|_|_| |_|_|_|   |_|  \___/|_| |_| |_| .__/ \__|
#                                            | |
#                                            |_|

# MiniPrompt, a lighting fast, yet, feature rich bash shell prompt!


#-------------------=== Prompt Config ===-------------------------------

# prompt symbols
success_symbol="λ"
error_symbol="✗"
git_branch_icon=""
kube_icon=""

# other
reset="\[\e[m\]"
this="$(basename "${BASH_SOURCE[0]}")"
skip_init=false
# usr_content="\w"
usr_content="[\[\e[3;33m\]\w\[\e[0m\]]\[\e[1;32m\]"

# main functionalities
ssh_prompt=true
my_bin=false
add_exit=true

# extensions
extensions_main=false
GIT_PROMPT=true
KUBE_PROMPT=false

script_help=$( cat << EOF

This script simplifies the process of changing MiniPrompt's configuration variables
on the fly for the current terminal session

Usage:
    #0: ${this} [arg] <modifier(s)>
    #1: ${this} [flag]
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
    #0: $this gp t
        Explanation: This will export the 'GIT_PROMPT' variable as true (enables it to show branch on prompt)
    #1: $this ex f
        Explanation: This will export the 'extensions_main' variable as false (disables all extensions)
    #2: $this ae t
        Explanation: This will export the 'add_exit' variable as true (enables exit status to be shown on prompt)

EOF
)


#-------------------=== Colors ===-------------------------------
# main
light_green="\[\e[1;32m\]"
light_red="\[\e[1;31m\]"
yellow="\[\e[0;33m\]"
gray="\[\e[0;37m\]"

# secondary
# \[\033[<num_for_syle>;<num_for_color>m\] = color
# e.g: \[\033[02;32m\] = green text in italics
# \[\033[00m\]

# uncomment the ones you'd like to use :)

# invisible="\[\033[01;30m\]"
# white="\[\033[00m\]"
# green="\[\033[01;32m\]"
# red="\[\033[01;31m\]"
# yellow="\[\033[01;33m\]"
# blue="\[\033[01;34m\]"
# purple="\[\033[01;35m\]"
# cyan="\[\033[01;36m\]"

# bright_white="\[\033[01;37m\]"
# white_text_over_red="\[\033[01;41m\]"
# white_text_over_gree="\[\033[01;42m\]"
# white_text_over_yellow="\[\033[01;43m\]"
# white_text_over_blue="\[\033[01;43m\]"
# white_text_over_purple="\[\033[01;43m\]"
# white_text_over_cyan="\[\033[01;43m\]"
# white_text_over_gray="\[\033[01;43m\]"
# white_text_over_yellow="\[\033[01;43m\]"

#-------------------=== Annotations ===-------------------------------
# * `command -v <cmd>` is faster thatn `which <cmd>`, so keet it

#-------------------=== Configuration Funcs ===-------------------------------


function config_autocomplete() {
    bind 'set colored-stats on'
    bind 'set colored-completion-prefix on'
    bind 'set completion-ignore-case on'
    bind 'set completion-map-case on'
    bind 'set expand-tilde on'
    bind 'set mark-directories on'
    bind 'set mark-symlinked-directories on'
    bind 'set show-all-if-ambiguous on'
    bind 'set show-all-if-unmodified on'
    bind 'set skip-completed-text on'
    shopt -s 'cdspell'
    shopt -s 'checkwinsize'
    shopt -s 'dirspell'
}

function config_dircolors() {
    if [ -x "$(command -v dircolors)" ]; then
        if [ -r "$HOME/.dircolors" ]; then
            eval "$(dircolors -b "$HOME/.dircolors")"
        else
            eval "$(dircolors -b)"
        fi
    fi
}

function config_history_format() {
    export HISTCONTROL='ignoreboth:erasedups'
    export HISTTIMEFORMAT='[%Y-%m-%d %T] '
    shopt -s 'histappend'
}

function config_extensions() {
    export bin_git
    export bin_kubectl
    bin_git="$(command -v git)"
    bin_kubectl="$(command -v kubectl)"
}

function config_my_bin() {
    if [[ "$my_bin" == "false" ]]; then
        :
    elif [[ "$my_bin" == "true" ]]; then
        for config in "$(dirname "$(miniprompt_path)")"/config.d/*.sh; do
            source "$config"
        done

        for config in "$HOME/.profile" "$HOME/.bash_aliases"; do
        if [ -f "$config" ]; then
          source "$config"
        fi
        done
    else
        echo -e "Variable 'my_bin' was set to '$my_bin', which is not a valid value. It can only be set to 'true' or 'false' in $this located at `miniprompt_path`."
    fi
}

# config funcs 'main'
function configure_miniprompt() {

    export PS1_previous_exit
    export PS1_prefix
    export PS1_content
    export PS1_suffix

    config_autocomplete
    config_dircolors
    config_history_format
    config_extensions
    config_my_bin
}


function miniprompt_path() {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
}



# prepares the prompt variables
function reset_prompt() {
    export PS1_previous_exit="$?"
    export PS1_prefix="\[\e]0;\w\a\]"   # window title
    # export PS1_content="[\[\e[3;33m\]${usr_content}\[\e[0m\]]\[\e[1;32m\]"
    export PS1_content="${usr_content}"

    # examples for PS1:
        # export PS1_content='\[\033[00m\]\w\[\e[0m\]\[\e[1;32m\]'
        # export PS1_content='\[\e[1m\]\w\[\e[0m\]'
        # export PS1_content='\[\e]0;\u@\h: \w\a\]\e[1;34m\e[3;32m\w\e[0m\e[0m > '

    export PS1_suffix=" ${success_symbol}\[\e[0m\] "
}

# make PS1_suffix red if the previous command failed
function add_exit_code_to_prompt() {
    if [[ "$add_exit" == "true" ]]; then
        [ "$PS1_previous_exit" -ne 0 ] && PS1_suffix="${light_red} ${error_symbol} ${reset}"
    elif [[ "$add_exit" == "false" ]]; then
        :
    else
        echo -e "Configuration variable 'add_exit' was set to '$add_exit', which is not a valid value. It can either be set to 'true' or 'false' in $this located at `miniprompt_path`, otherwise you'll see this message"
    fi
}

function add_git_to_prompt() {
    if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ]]; then
        # local branch=`git branch --show-current`
        PS1_content="${PS1_content:-} (${git_branch_icon} `git branch --show-current`)"
    else
        :
    fi
}

# display kubernetes context name and namespace
function add_kube_to_prompt() {
    local context
    local namespace
    context="$(kubectl config view -o=jsonpath='{.current-context}')"
    namespace="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${context}\")].context.namespace}")"
    PS1_content="${PS1_content:-} ${kube_icon}\[\e[34m\]${context}${namespace:+:$namespace}\[\e[0m\]"
}


# prepend user@hostname to prompt, if connected via ssh
function add_ssh_to_prompt() {
    if [[ "$ssh_prompt" == "true" ]]; then
        if [[ -n "$SSH_CONNECTION" ]]; then
            PS1_prefix='\[\e]0;\u@\h \w\a\]'
            PS1_content="\[\e[2m\]\u@\h\[\e[0m\] ${PS1_content}"
        else
            :
        fi
    elif [[ "$ssh_prompt" == "false" ]]; then
        :
    else
        echo -e "Configuration variable 'ssh_prompt' was set to '$ssh_prompt', which is not a valid value. It can either be set to 'true' or 'false' in $this located at `miniprompt_path`, otherwise you'll see this message"
    fi
}

function test_extension() {
    extension_name=$1
    extension_boolean=$2
    bin_cmd=$3
    if_true=$4

    if [[ "$extension_boolean" == "false" ]]; then
        :
    elif [[ "$extension_boolean" == "true" ]] && [[ ! -z "$bin_cmd" ]]; then
        eval $if_true
    else
        echo -e "Extension '$extension_name' was set to '$extension_boolean', which is not a valid value. It can either be set to 'true' or 'false' in $this located at `miniprompt_path`."
    fi
}


# set the prompt
function main_prompt() {
    # chage prompt accordingly
    reset_prompt
    add_exit_code_to_prompt
    add_ssh_to_prompt

    # test extensions
    if [[ "$extensions_main" == "false" ]]; then
        :
    elif [[ "$extensions_main" == "true" ]]; then
        test_extension "Git Branch" $GIT_PROMPT $bin_git "add_git_to_prompt"
        test_extension "Kubernetes Container" $KUBE_PROMPT $bin_kubectl "add_kube_to_prompt"
    else
        echo -e "Configuration variable 'extensions_main' was set to '$extensions_main', which is not a valid value. It can either be set to 'true' or 'false' in $this located at `miniprompt_path`, otherwise you'll see this message"
    fi

    # finally!
    export PS1="${PS1_prefix:-}${PS1_content:-}${PS1_suffix:-}"
    history -a
    clean_variables
}

# clean up (unset) shared mini_prompt variables (e.g. prefix and suffix)
function clean_variables() {
    unset PS1_prefix \
        PS1_content \
        PS1_suffix \
        PS1_previous_exit
}

# initialize the program
function __init() {
    if [[ "$-" == *i* ]]; then
        configure_miniprompt
        if [[ "$PROMPT_COMMAND" != *main_prompt* ]]; then
          export PROMPT_COMMAND="main_prompt;$PROMPT_COMMAND"
        fi
    fi
}

if [[ "$skip_init" == "false" ]]; then
    __init
elif [[ "$skip_init" == "true" ]]; then
    : # skips initialization
else
    echo -e "Configuration variable 'skip_init' was set to '$skip_init', which is not a valid value. It can either be set to 'true' or 'false' in $this located at `miniprompt_path`, otherwise you'll see this message"
fi


