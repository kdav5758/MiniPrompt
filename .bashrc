# =============================================================================
# MiniPrompt
# =============================================================================

#-------------------=== aliases ===-------------------------------
alias start_mp='source /home/sebas5758/code/github_p/MiniPrompt/mini_prompt.sh'
alias odf='source /home/sebas5758/code/github_p/MiniPrompt/on_da_fly.sh'

#-------------------=== vars ===-------------------------------
MINIPROMPT_ENABLED=true

#-------------------=== resources ===-------------------------------

if [[ "$MINIPROMPT_ENABLED" == "true" ]]; then
    : # source the file
    source /home/sebas5758/code/github_p/MiniPrompt/mini_prompt.sh
elif [[ "$MINIPROMPT_ENABLED" == "false" ]]; then
    : # don't source it
    PS1="\[\033[01;32m\]\w\[\033[00m\]\[\033[01;39m\] >\[\033[00m\] "
else
    echo -e "Configuration variable 'MINIPROMPT_ENABLED' was set to '$MINIPROMPT_ENABLED', which is not a valid value. It can either be set to 'true' or 'false' in the ~/.bashrc file."
fi

