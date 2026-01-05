{ pkgs, ... }:
let
  myAliases = {
    "c" = "clear";
    "ls" = "eza -lho --group-directories-first --no-time --icons";
    "cat" = "bat --style=plain";
    "grep" = "rg";
    "rm" = "rm -v";
    "mv" = "mv -iv";
    "cp" = "cp -riv";
    "mkdir" = "mkdir -vp";
    "n" = "nvim";
    "y" = "yazi";
    "nf" = "fd -H -tf | fzf  --prompt='edit file: ' --preview 'bat --style=numbers --color=always {}' --border-label='╢Edit File╟'| xargs -r $EDITOR";
    "fpdf" = "fd -tf --glob '*.pdf' | fzf --border=double --prompt='Open PDF: ' | xargs  -r zathura";
    "fy" = "yazi $(fd -t d | fzf)";
    "ac" = "ani-cli";
    "z" = "zathura";
  };
in
{
  home.packages = with pkgs; [
    ani-cli
    atool
    cowsay
    bottom
    btop
    htop
    ripgrep
    killall
    tldr
    bat
    eza
    cmatrix
    asciiquarium
    cbonsai
    fd
    urlscan
    lazygit
    pipes-rs
    ghc
    sl
    gap
    yazi
  ];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--border=double"
      "--header='ESC to quit'"
      "--pointer='→'"
    ];
    historyWidgetOptions = [
      "--border-label='╢ Shell History╟'"
      "--prompt='Search Shell History: '"
      "--height=100%"
    ];
    changeDirWidgetOptions = [
      "--border-label='╢ CD ╟'"
      "--prompt='Change Directory To: '"
      "--preview ='eza -T --level=3 {}'"
      "--height=100%"
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = myAliases;
    history = {
      size = 10000;
      #path = "${config.xdg.dataHome}/zsh/history";
    };
    initContent = ''
      set -o vi
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      export PS1="%{$(tput setaf 15)%}%n%{$(tput setaf 15)%}@%{$(tput setaf 15)%}%m %{$(tput setaf 13)%}%1~ %{$(tput sgr0)%}$ "
    '';
  };
  programs.bash = {
    enable = false;
    enableCompletion = true;
    shellAliases = myAliases;
  };
}
