# Initialize colors.
autoload -U colors
colors

[[ -e ~/.zsh/colors.zsh ]] && which async_init &> /dev/null && source ~/.zsh/colors.zsh

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

# ASYNC
# mostly taken from
# https://gist.github.com/denysdovhan/e83dec6f09b237acbc24a6bb25fabd13

function prompt_git {
    cd -q $1
    update_current_git_vars 2>&1
    prompt_git_info
}

prompt_refresh() {
    zle && zle .reset-prompt
}

prompt_callback() {
    local job=$1 code=$2 output=$3 exec_time=$4
    git_info=$output
    prompt_refresh
}


prompt_init_worker(){
    async_start_worker 'prompt'
    async_register_callback 'prompt' prompt_callback
}

prompt_async_precmd() {
    async_job 'prompt' prompt_git $PWD || prompt_init_worker
}

prompt_precmd(){
    git_info=$(prompt_git_info)
}

# check for zsh-async
if (which async_init &> /dev/null); then
    async_init
    # Start async worker
    prompt_init_worker

    # Setup
    zmodload zsh/zle
    # Append git functions needed for prompt.
    precmd_functions+='prompt_async_precmd'
else
    # Append git functions needed for prompt.
    preexec_functions+='preexec_update_git_vars'
    chpwd_functions+='update_current_git_vars'
    precmd_functions+='prompt_precmd'
fi
