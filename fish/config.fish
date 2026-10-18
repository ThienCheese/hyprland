if status is-interactive
    set -g fish_greeting ""
end
oh-my-posh init fish --config /home/cheese/.cache/oh-my-posh/themes/cheese.omp.json | source
alias l="ls -la"
alias ff="fastfetch"

