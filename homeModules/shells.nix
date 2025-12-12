{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      edit = "emacs -nw";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
  };

  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        ''
          zsh-users/zsh-autosuggestions
          ohmyzsh/ohmyzsh path:lib/git.zsh
          romkatv/powerlevel10k
          amyreese/zsh-titles
          zsh-users/zsh-syntax-highlighting
        ''
      ];
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    shellAliases = {
      ll = "ls -l";
      l = "ls -l";
      la = "ls -la";
      edit = "emacs -nw";
      cd = "z";
    };
    autocd = true;
    initContent = lib.mkOrder 1200 ''
      source ~/.p10k.zsh
    ''; # for p10k;
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
  };

  # Zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enableZshIntegration = true;
}
