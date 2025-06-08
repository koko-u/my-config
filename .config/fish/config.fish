if status is-interactive
    # Commands to run in interactive sessions can go here
    # rust
    if test -d "$HOME/.cargo"
        fish_add_path "$HOME/.cargo/bin"
        source "$HOME/.cargo/env.fish"
    end

    # mise
    if type -q mise
        mise activate fish | source
    else
        echo no mise executable
    end

    # dotnet
    if test -d "$HOME/.dotnet"
        fish_add_path "$HOME/.dotnet/tools"
        set -xg DOTNET_ROOT (mise where dotnet)
        complete -f -c dotnet -a "(dotnet complete (commandline -cp))"
    end

    # yarn
    if type -q yarn
        fish_add_path (yarn global bin)
    end

    # # pnpm
    # if type -q $HOME/.local/share/mise/shims/pnpm
    #     fish_add_path ($HOME/.local/share/mise/shims/pnpm config get global-bin-dir)
    # else
    #     echo no pnpm executable
    # end

    # direnv
    if type -q $HOME/.local/share/mise/shims/direnv
        $HOME/.local/share/mise/shims/direnv hook fish | source
    else
        echo no direnv executable
    end

    # eza
    if type -q eza
        alias ls='eza'
        alias ll='eza -lg'
        alias tree='eza -T'
    end

    # atuin
    if type -q atuin
        set -gx ATUIN_NOBIND true
        atuin init fish | source

        # bind to ctrl-r in normal and insertr mode
        # add any other bindings here
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search
    end

    # jetbrains
    if test -d "$HOME/.local/share/JetBrains/Toolbox"
        fish_add_path "$HOME/.local/share/JetBrains/Toolbox/scripts"
    end

    # haskell
    if test -d "$HOME/.ghcup"
        set -gx GHCUP_INSTALL_BASE_PREFIX $HOME
        fish_add_path "$HOME/.cabal/bin"
        fish_add_path "$HOME/.ghcup/bin"
    end

    # add .local/bin to path
    if test -d "$HOME/.local/bin"
        fish_add_path "$HOME/.local/bin"
    end
end
