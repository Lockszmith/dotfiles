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

## Troubleshooting
Run the [`sz-doctor.sh`](_home/bin/executable_sz-doctor.sh) shell script, it should be installed into the `~/bin` dir by chezmoi, if chezmoi fialed, you can still download it directly from the web buy running:

```
> curl -fsLS lksz.me/sz-doctor.sh | bash
```

