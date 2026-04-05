{
  config,
  lib,
  pkgs,
  ...
}:
let
  globalSessionVariables = config.home.sessionVariables;
  globalShellAliases = {
    ls = "eza";
    ll = "ls -l";
    l = "ls -l";
    la = "ls -la";
    cd = "z";
  };
in
{
  home.shell = {
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.bash = {
    enable = true;
    sessionVariables = globalSessionVariables;
    shellAliases = globalShellAliases;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./externalConfigs/starship.toml;

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    antidote = {
      enable = true;
      plugins = [
        ''
          zsh-users/zsh-autosuggestions
          ohmyzsh/ohmyzsh path:lib/git.zsh
          amyreese/zsh-titles
          zsh-users/zsh-syntax-highlighting
          jeffreytse/zsh-vi-mode
        ''
      ];
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    shellAliases = globalShellAliases;
    autocd = true;
    completionInit = ''
      zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
      zstyle ':completion:*' expand prefix suffix
      zstyle ':completion:*' list-colors ""
      zstyle ':completion:*' list-suffixes true
      zstyle ':completion:*' matcher-list "" 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
      zstyle ':completion:*' max-errors 3
      zstyle ':completion:*' preserve-prefix '//[^/]##/'
      zstyle ':completion:*' verbose true

      autoload -Uz compinit
      compinit
    '';
    sessionVariables = globalSessionVariables;
  };

  # Fish
  programs.fish = {
    enable = true;
    plugins = map (x: { inherit (x) name src; }) (
      with pkgs.fishPlugins;
      [
        plugin-git
        fzf-fish
        puffer
      ]
    );
    shellInit = "set -g fish_greeting";
    shellAliases = globalShellAliases;
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
