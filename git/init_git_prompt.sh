# Initialize colors.
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
: ${ZSH_GIT_COLORS[diverged]:="red"}
: ${ZSH_GIT_COLORS[copied]:="yellow"}
: ${ZSH_GIT_COLORS[renamed]:="yellow"}
: ${ZSH_GIT_COLORS[untracked]:="red"}
: ${ZSH_GIT_COLORS[stashed]:="white"}

# define default symbols
typeset -gA ZSH_GIT_SYMBOLS
: ${ZSH_GIT_SYMBOLS[modified]:="M"}
: ${ZSH_GIT_SYMBOLS[deleted]:="-"}
: ${ZSH_GIT_SYMBOLS[added]:="+"}
: ${ZSH_GIT_SYMBOLS[renamed]:="↹"}
: ${ZSH_GIT_SYMBOLS[copied]:="↷"}
: ${ZSH_GIT_SYMBOLS[untracked]:="?"}
: ${ZSH_GIT_SYMBOLS[conflict]:="⚡"}
: ${ZSH_GIT_SYMBOLS[stashed]:="S"}
: ${ZSH_GIT_SYMBOLS[diverged]:="↕"}
: ${ZSH_GIT_SYMBOLS[ahead]:="↑"}
: ${ZSH_GIT_SYMBOLS[behind]:="↓"}
: ${ZSH_GIT_SYMBOLS[ahead_behind]:="⇅"}

__zsh_symbol_color_helper(){
    echo '%F{'"$ZSH_GIT_COLORS[$1]"'}'"$ZSH_GIT_SYMBOLS[$1]"
}

# default state strings combined from symbol and color
typeset -gA ZSH_GIT_STATE_STRINGS
: ${ZSH_GIT_STATE_STRINGS[ M]:="$(__zsh_symbol_color_helper modified)"}
: ${ZSH_GIT_STATE_STRINGS[M ]:="$(__zsh_symbol_color_helper renamed)"}
: ${ZSH_GIT_STATE_STRINGS[MM]:="$(__zsh_symbol_color_helper renamed)$(__zsh_symbol_color_helper modified)"}
: ${ZSH_GIT_STATE_STRINGS[D ]:="$(__zsh_symbol_color_helper deleted)"}
: ${ZSH_GIT_STATE_STRINGS[ D]:="$(__zsh_symbol_color_helper deleted)"}
: ${ZSH_GIT_STATE_STRINGS[RM]:="$(__zsh_symbol_color_helper renamed)"}
: ${ZSH_GIT_STATE_STRINGS[A ]:="$(__zsh_symbol_color_helper added)"}
: ${ZSH_GIT_STATE_STRINGS[C ]:="$(__zsh_symbol_color_helper copied)"}
: ${ZSH_GIT_STATE_STRINGS[??]:="$(__zsh_symbol_color_helper untracked)"}
: ${ZSH_GIT_STATE_STRINGS[UU]:="$(__zsh_symbol_color_helper conflict)"}

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
