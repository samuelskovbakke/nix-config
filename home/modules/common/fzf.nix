{
  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;

    defaultCommand = "fd --type f --strip-cwd-prefix";
    defaultOptions = ["--height 40%" "--layout=reverse" "--border"];

    fileWidget.command = "fd --type f --strip-cwd-prefix";
    fileWidget.options = ["--preview 'bat --color=always --style=numbers --line-range=:500 {}'"];

    changeDirWidget.command = "fd --type d --strip-cwd-prefix";
    changeDirWidget.options = ["--preview 'ls --color=always {}'"];

    enableFishIntegration = true; # since your shell is fish
  };
}
