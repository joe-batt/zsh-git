# Initialize colors.
autoload -U colors
colors

# Allow for functions in the prompt.

# Autoload zsh functions.
fpath=($ZSH_GIT_DIR/git/include $fpath)
autoload -U $ZSH_GIT_DIR/git/include/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
chpwd_functions+='update_current_git_vars'
precmd_functions+='precmd_update_git_vars'
