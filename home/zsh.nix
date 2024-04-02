{ pkgs, ... }:
let
  functionsScripts = pkgs.writeShellScript "zshfunctions" ''
    fzfvim(){
    # find file in $1, open it with vim and put it into clipboard
    	file=$(find -L $1 | fzf)
    		if [[ ! -z $file ]]; then
    			vim $file
    				fi
    				echo $file
    				echo -n "$file" | pbcopy
    }
    cf(){
    	fzfvim "$HOME/.config"
    }
    cdot(){
    	fzfvim "$HOME/.dots"
    }
    sc(){
    	fzfvim "$HOME/.scripts"
    }
    co(){
    	fzfvim "$HOME/Code"
    }
    c() {
    # change directory and list its files
    	cd "$@" && ls;
    }

    gop() { # go project
    	choice=$(find ~ -maxdepth 6 -type d -o -type l | fzf)
    		[[ ! -z $choice ]] \
    		&& cd $choice \
    			&& ls -l
    }

    zat() {
    # open zathura in background
    	zathura $1 & exit;
    }

    copy_chmod_chown(){
    	sudo chmod --reference=$1 $2
    	sudo chown --reference=$1 $2
    }

    f(){
    	q=$(echo "$@" | sed 's/\s\+/%20/g')
    	open "https://google.com/search?q=$q";
    }

    git-last-commits(){
    	NL=$'\n'

    	branches=$(git branch -r | awk '{print $1}')
    	results="";

    	while read branch_name; do
    		result=$(git show \
    				--color=always \
    				--pretty=format:"%Cgreen%ci %Cblue%cr %Cred%cn %Creset" $branch_name \
    				| head -n 1)
    					 results="$results''${NL}$result#$branch_name"
    					 done <<< "$branches"
    					 echo "$results" | sort -r | column -t -s'#' | tr '#' ' '
    }

    video_to_facebook(){
    	filename=$(basename $1 .mp4)
    	ffmpeg -i $1 -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -vf format=yuv420p -movflags +faststart "$filename"_h264.mp4
    }

    proj(){
    	folder=~/Apps
    	choice=$(ls $folder | fzf)
    	[[ ! -z $choice ]] && cd "$folder/$choice" && ls -la
    }

    lfcd () {
    	tmp="$(mktemp)"
    	lf -last-dir-path="$tmp" "$@"
    	if [ -f "$tmp" ]; then
    		dir="$(cat "$tmp")"
    		rm -f "$tmp"
    		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    	fi
    }
  '';
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    defaultKeymap = "viins";
    shellAliases = {
      ls = "lsd";
      la = "lsd -a";
      ll = "lsd -l";

      lg = "lazygit";

      cdn = "cd ~/Code/nix-darwin";

      mv = "mv -v";
      cp = "cp -v";
      rm = "rm -v";

      q = "exit";
      ":q" = "exit";

      vim = "nvim";
    };
    envExtra = ''
      			export HISTFILE=$HOME/.zsh_history
      			'';
    initExtra = ''
      			source ${functionsScripts}


      			bindkey '^R' history-incremental-search-backward

      			setopt noincappendhistory
      			setopt nosharehistory
      			setopt appendhistory

      			[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ] && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
      			[ -f /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme ] && source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
      			[ -f "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

      			if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      				source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      			fi

      			[[ ! -f ~/.dots/zsh/.p10k.zsh ]] || source ~/.dots/zsh/.p10k.zsh
      		'';
  };
}
