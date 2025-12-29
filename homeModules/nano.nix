{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".config/nano/nanorc".text = ''
    set autoindent
    set casesensitive
    set breaklonglines
    set cutfromcursor
    set historylog
    set indicator
    set linenumbers
    set magic
    set mouse
    set regexp
    set smarthome
    set tabstospaces
    set tabsize 2
  '';
}
