# =============================================================================
# MiniPrompt
# =============================================================================

#-------------------=== aliases ===-------------------------------
alias start_mp='source /usr/local/bin/MiniPrompt*/mini_prompt.sh'
alias odf='source /usr/local/bin/MiniPrompt*/scripts/on_da_fly.sh'

#-------------------=== vars ===-------------------------------
MINIPROMPT_ENABLED=true

#-------------------=== resources ===-------------------------------

if [[ "$MINIPROMPT_ENABLED" == "true" ]]; then
    # source the file
    # check if current shell is interactive
    [[ $- == *i* ]] && source /usr/local/bin/MiniPrompt*/mini_prompt.sh || echo -e "You are currently not in an interactive shell, thus MiniPrompt can't load"
elif [[ "$MINIPROMPT_ENABLED" == "false" ]]; then
    # don't source it
    PS1="\[\033[01;32m\]\w\[\033[00m\]\[\033[01;39m\] >\[\033[00m\] "
else
    echo -e "Configuration variable 'MINIPROMPT_ENABLED' was set to '$MINIPROMPT_ENABLED', which is not a valid value. It can either be set to 'true' or 'false' in the ~/.bashrc file."
fi

