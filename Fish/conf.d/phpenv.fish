if test -d $HOME/.phpenv/bin
    fish_add_path $HOME/.phpenv/bin
    phpenv init - | source
end
