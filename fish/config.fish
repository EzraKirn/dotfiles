if status is-interactive
    # # Check if inside tmux already
    # if not set -q TMUX
    #     # Try to attach to an existing session, or create a new one named 'main'
    #     if tmux attach-session -t main 2>/dev/null
    #         # Attached successfully
    #     else
    #         tmux new-session -s main
    #     end
    # end
  neofetch
end

set -gx TERM "tmux-256color"


# Aliases
alias vi="nvim" 
alias clr="clear" 
alias tls="tmux list-sessions" 
alias sl="ls -1 -A --group-directories-first" 
alias activate="source .env/bin/activate.fish" 
alias mkenv="python3 -m venv .env" 
alias pyrun="python3 main.py" 


# vcpackage bulshit
set -x VCPKG_ROOT ~/vcpkg
set -x PATH $VCPKG_ROOT $PATH

function copyfile
    set filename $argv[1]
    if test -f $filename
        begin
            echo $filename
            echo
            cat $filename
        end | xclip -selection clipboard
        echo "Copied $filename and its contents to clipboard."
    else
        echo "File not found: $filename"
    end
end

set -gx PATH $HOME/.cargo/bin $PATH
