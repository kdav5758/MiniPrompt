#!/bin/bash

#-------------------=== Prompt Config ===-------------------------------
success_symbol="λ"
error_symbol="✗"
reset="\[\e[m\]"
skip_init=false
GIT_PROMPT=false
KUBU_PROMPT=false
ssh_prompt=true
my_bin=false
add_exit=true
this_basename=`basename "$0"`

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
invisible="\[\033[01;30m\]"
white="\[\033[00m\]"
green="\[\033[01;32m\]"
red="\[\033[01;31m\]"
yellow="\[\033[01;33m\]"
blue="\[\033[01;34m\]"
purple="\[\033[01;35m\]"
cyan="\[\033[01;36m\]"

bright_white="\[\033[01;37m\]"
white_text_over_red="\[\033[01;41m\]"
white_text_over_gree="\[\033[01;42m\]"
white_text_over_yellow="\[\033[01;43m\]"
white_text_over_blue="\[\033[01;43m\]"
white_text_over_purple="\[\033[01;43m\]"
white_text_over_cyan="\[\033[01;43m\]"
white_text_over_gray="\[\033[01;43m\]"
white_text_over_yellow="\[\033[01;43m\]"

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
    export __xelabash_git_bin
    export __xelabash_kubectl_bin
    __xelabash_git_bin="$(command -v git)"
    __xelabash_kubectl_bin="$(command -v kubectl)"
}

function config_my_bin() {
    if [[ "$my_bin" == "false" ]]; then
        :
    elif [[ "$my_bin" == "true" ]]; then
        for config in "$(dirname "$(__xelabash_path)")"/config.d/*.sh; do
            source "$config"
        done

        for config in "$HOME/.profile" "$HOME/.bash_aliases"; do
        if [ -f "$config" ]; then
          source "$config"
        fi
        done
    else
        echo -e "Variable 'my_bin' was set to '$my_bin', which is not a valid value. It can only be set to 'true' or 'false' in $this_basename located at $0."
    fi
}

# config funcs 'main'
function configure_miniprompt() {
    export __xelabash_PS1_last_exit
    export __xelabash_PS1_prefix
    export __xelabash_PS1_content
    export __xelabash_PS1_suffix

    config_autocomplete
    config_dircolors
    config_history_format
    config_extensions
    config_my_bin
}


__xelabash_path() {
  echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
}



# prepares the prompt variables
function reset_prompt() {
    export __xelabash_PS1_last_exit="$?"
    export __xelabash_PS1_prefix=''
    __xelabash_PS1_prefix='\[\e]0;\w\a\]'   # window title
    export __xelabash_PS1_content='[\[\e[3;33m\]\w\[\e[0m\]]\[\e[1;32m\]'

    # examples for PS1:
        # export __xelabash_PS1_content='\[\033[00m\]\w\[\e[0m\]\[\e[1;32m\]'
        # export __xelabash_PS1_content='\[\e[1m\]\w\[\e[0m\]'

    export __xelabash_PS1_suffix=' ${success_symbol}\[\e[0m\] '
}

# make __xelabash_PS1_suffix red if the previous command failed
function add_exit_code_to_prompt() {
    if [[ "$add_exit" == "true" ]]; then
        [ "$__xelabash_PS1_last_exit" -ne 0 ] && __xelabash_PS1_suffix="${light_red} ${error_symbol} ${reset}"
    elif [[ "$add_exit" == "false" ]]; then
        :
    else
        echo -e "Configuration variable 'add_exit' was set to '$add_exit', which is not a valid value. It can either be set to 'true' or 'false' in $this_basename located at $0, otherwise you'll see this message"
    fi
}

# display git branch and repo state asterisk after path, if inside of a repository
function add_git_to_prompt() {
    local prompt
    local branch
    local status_count

    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ] || [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" = 'true' ]; then

        branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
        [ -z "$branch" ] && branch='(no branch)'

        if [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" != 'true' ]; then
          status_count="$(git status --porcelain | wc -l)"
        fi

    elif [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = 'true' ]; then
        branch='(bare repo)'
    fi

    if [ -n "$branch" ]; then
        if [ "${status_count:-0}" -gt 0 ]; then
            prompt="\[\e[1;33m\]${branch}*\[\e[0m\]"
        else
            prompt="\[\e[36m\]${branch}\[\e[0m\]"
        fi
        __xelabash_PS1_content="${__xelabash_PS1_content:-} ${prompt}"
    fi
}

# display kubernetes context name and namespace
function add_kube_to_prompt() {
    local context
    local namespace
    context="$(kubectl config view -o=jsonpath='{.current-context}')"
    namespace="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${context}\")].context.namespace}")"
    __xelabash_PS1_content="${__xelabash_PS1_content:-} \[\e[34m\]${context}${namespace:+:$namespace}\[\e[0m\]"
}

function test_extension() {
    extension_name=$1
    extension_boolean=$2
    bin_cmd=$3
    if_true=$4

    if [[ "$extension_boolean" == "false" ]]; then
        :
    elif [[ "$extension_boolean" == "true" ]] && [[ -z "$cmd" ]]; then
        eval $if_true
    else
        echo -e "Extension '$extension_name' was set to '$extension_boolean', which is not a valid value. It can either be set to 'true' or 'false' in $this_basename located at $0."
    fi
}

# prepend user@hostname to prompt, if connected via ssh
function add_ssh_to_prompt() {
    if [[ "$ssh_prompt" == "true" ]]; then
        if [[ -n "$SSH_CONNECTION" ]]; then
            __xelabash_PS1_prefix='\[\e]0;\u@\h \w\a\]'
            __xelabash_PS1_content="\[\e[2m\]\u@\h\[\e[0m\] ${__xelabash_PS1_content}"
        else
            :
        fi
    elif [[ "$ssh_prompt" == "false" ]]; then
        :
    else
        echo -e "Configuration variable 'ssh_prompt' was set to '$ssh_prompt', which is not a valid value. It can either be set to 'true' or 'false' in $this_basename located at $0, otherwise you'll see this message"
    fi
}

# set the prompt
function main_prompt() {
    # chage prompt accordingly
    reset_prompt
    add_exit_code_to_prompt
    add_ssh_to_prompt

    # test extensions
    test_extension "Git Branch" $GIT_PROMPT $__xelabash_git_bin "__xelabash_add_git_to_prompt"
    test_extension "Kubernetes Container" $KUBU_PROMPT $__xelabash_kubectl_bin "add_kube_to_prompt"

    # finally!
    export PS1="${__xelabash_PS1_prefix:-}${__xelabash_PS1_content:-}${__xelabash_PS1_suffix:-}"
    history -a
    clean_variables
}

# clean up (unset) shared mini_prompt variables (e.g. prefix and suffix)
function clean_variables() {
    unset __xelabash_PS1_prefix \
        __xelabash_PS1_content \
        __xelabash_PS1_suffix \
        __xelabash_PS1_last_exit
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
    echo -e "Configuration variable 'skip_init' was set to '$skip_init', which is not a valid value. It can either be set to 'true' or 'false' in $this_basename located at $0, otherwise you'll see this message"
fi


