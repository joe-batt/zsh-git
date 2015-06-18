# zsh-git

This project is yet another fancy prompt that provides you with information about the current git directory.

The prompt is split into two parts: the full prompt and the actual git module. This means you can include the git 
info part in your favorite prompt, if you don't want to use the full prompt.


## Installation
Put all files into the <tt>.zsh</tt> directory in your home, if you don't have one, create it.
To use the full prompt, you need to put the following in your <tt>.zshrc</tt> :
```zsh
fpath=(~/.zsh/prompt $fpath)     
autoload -Uz promptinit && promptinit
prompt joe
```

if you only wish to use the git info, you need to put:
```zsh
setopt prompt_subst
source ~/.zsh/git/init_git_prompt.sh
```

Now you can use <tt>$(prompt_git_info)</tt> in your own prompt definition to show the git info

## Customization
The git part does not allow customisation yet. But you can choose all colors used in the regular prompt:
```
prompt joe [<color1> [<color2> [<color3> [<color4> [<color5>]]]]]
        color1: user@host (non-root user)
        color2: [24:00:00] (time)
        color3: /path/ (pwd)
        color4: [jobs: 1] (jobcount in right prompt)
        color5: host (like user@host but for root)
```
