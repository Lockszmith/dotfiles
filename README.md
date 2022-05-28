## chezmoi dotfiles repo
          
## Quickest init + apply  
1. Make sure `curl` is installed
> ```    
> # Bash/Sh/Zsh
> . <(curl -fsLS lksz.me/dotfiles.sh)
> 
> # PowerShell
> . <(curl -fsLS lksz.me/dotfiles.ps1)
> ```

## Quick install
Initialize `chezmoi` and `apply`:   
#### using GitHub HTTPS shorthand
```
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply Lockszmith                            
```
 
#### using GitHub over SSH
1. Make sure the SSH-Key are setup in [SSH and GPG Keys](https://github.com/settings/keys) ([add](https://github.com/settings/ssh/new))
```
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply git@github.com:Lockszmith/dotfiles.git
```
