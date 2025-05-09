export PATH="/home/thiew/.local/bin:$PATH"
export PATH="/home/thiew/.local/share/yabridge:$PATH"
export PATH="/home/thiew/.platformio/penv/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
	git-prompt
)

source $ZSH/oh-my-zsh.sh

# clear puts pokemon on top, for normal clear do clearall
clearall() {
  clear
}
alias clear="clearall && pokemon-colorscripts --no-title -s -r"

#full valgrind flags
alias valfull="valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --track-fds=yes -s"

#python
alias py="python"
#android-studio
alias android="~/.local/android-studio/bin/studio.sh"

#check directory disk usage
alias dir_space="du -h . -d 1 | sort -rh"

#wallpaper wall-norm is animated wall-save is non animated one
alias wall-norm="$HOME/.scripts/background_changer.sh norm"
alias wall-save="$HOME/.scripts/background_changer.sh save"
alias wall-variant="$HOME/.scripts/background_changer.sh variant"
#changing light/dark theme
alias light="kitten themes light-theme"
alias dark="kitten themes dark-theme"

#projucer
alias projucer="/home/thiew/git_apps/juce/extras/Projucer/Builds/LinuxMakefile/build/Projucer"
alias projucer-host="/home/thiew/git_apps/juce/extras/AudioPluginHost/Builds/LinuxMakefile/build/AudioPluginHost"
#nvim source
alias nvimSource="source ~/.config/nvim/lua/nism/init.lua"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
pokemon-colorscripts --no-title -s -r

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

