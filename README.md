# zsh-git

This project is yet another fancy prompt that provides you with information about the current git directory. In a git repository, the prompt looks like this:

![the prompt](http://joe-batt.github.io/prompt.png)

The prompt is split into two parts: the full prompt and the actual git module. This means you can include the git 
info part in your favorite prompt, if you don't want to use the full prompt.

I started out with concept in this <a href="http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/">blog post</a>.

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

Now you can use <tt>$(prompt\_git\_info)</tt> in your own prompt definition to show the git info

## git Information Reference
![reference](http://joe-batt.github.io/git-prompt-desc.png)

## Customization
Both regular prompt and git part use dictionaries for customisation, you can set 
these in your config to override defaults. 
### General Prompt
The regular
prompt uses the variable <tt>ZSH\_JOE\_COLORS<tt>, the possible keys are:
- **user**: color of user@host
- **time**: color of timestamp
- **pwd**: color of working directory path
- **jobs**: color of job counter on the right
- **root**: color for root user

### Git Prompt
For the git prompt it is probably easiest to check the defaults in <tt>git/init\_git\_prompt.sh</tt>, for all possible settings. The three dictionaries in use are:
- <tt>ZSH\_GIT\_COLORS</tt> defines the colors for the branch and different markers (e.g. added)
- <tt>ZSH\_GIT\_SYMBOLS</tt> defines the correlated symbols used for markers
- <tt>ZSH\_GIT\_STATE\_STRINGS<tt> matches <tt>git status</tt> to the respective colored symbols, but can be overwritten in their entirety
