# zsh-git

This project is yet another fancy prompt that provides you with information about the current git directory. In a git repository, the prompt looks like this:

![the prompt](http://joe-batt.github.io/prompt.png)

The prompt is split into two parts: the full prompt and the actual git module. This means you can include the git 
info part in your favorite prompt, if you don't want to use the full prompt.

I started out with concept in this [blog post](http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/)

## Installation
Put all files into the `.zsh` directory in your home, if you don't have one, create it.
To use the full prompt, you need to put the following in your `.zshrc` :
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

Now you can use `${git_info}` in your own prompt definition to show the git info

### Optional: zsh-async
This prompt supports [zsh-async](https://github.com/mafredri/zsh-async)
for asynchronous display of the git information. Just install it somewhere and
source `async.zsh` before loading the prompt.


## Customization
Both regular prompt and git part use dictionaries for customisation, you can set 
these in your config to override defaults. 
### General Prompt
The regular
prompt uses the variable `ZSH_JOE_COLORS`, the possible keys are:
- **user**: color of user@host
- **time**: color of timestamp
- **pwd**: color of working directory path
- **jobs**: color of job counter on the right
- **root**: color for root user

### Git Prompt
For the git prompt it is probably easiest to check the defaults in `git/init_git_prompt.sh`, for all possible settings. The three dictionaries in use are:
- `ZSH_GIT_COLORS` defines the colors for the branch and different markers (e.g. added)
- `ZSH_GIT_SYMBOLS` defines the correlated symbols used for markers
- `ZSH_GIT_STATE_STRINGS` matches `git status` to the respective colored symbols, but can be overwritten in their entirety
