# Initialize colors.
typeset -A GIT_BRANCH_COLORS
autoload -U colors
colors

# define default colors
typeset -gA ZSH_GIT_COLORS
: ${ZSH_GIT_COLORS[branch]:="cyan"}
: ${ZSH_GIT_COLORS[ahead]:="green"}
: ${ZSH_GIT_COLORS[behind]:="blue"}
: ${ZSH_GIT_COLORS[ahead_behind]:="red"}
: ${ZSH_GIT_COLORS[modified]:="yellow"}
: ${ZSH_GIT_COLORS[added]:="green"}
: ${ZSH_GIT_COLORS[conflict]:="magenta"}
: ${ZSH_GIT_COLORS[deleted]:="red"}
: ${ZSH_GIT_COLORS[copied]:="yellow"}
: ${ZSH_GIT_COLORS[renamed]:="yellow"}
: ${ZSH_GIT_COLORS[untracked]:="red"}
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
