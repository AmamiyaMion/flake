SUDO_COMMAND := "sudo"
default: update rebuild

rebuild:
	{{SUDO_COMMAND}} nixos-rebuild switch --flake .

switch: rebuild

update:
	nix flake update

gc:
    {{SUDO_COMMAND}} nix-collect-garbage -d

clean: gc

optimise:
    nix store optimise

optimize: optimise

search +args:
    nix search nixpkgs {{args}}

se +args: (search args)

sr +args: (search args)

commit msg +files:
	git add {{files}}
	git commit -s -m '{{msg}}'

commit-all msg:
	git add -A
	git commit -s -m '{{msg}}'

push:
	git push

noproxy:
    {{SUDO_COMMAND}} dae suspend

proxy:
    {{SUDO_COMMAND}} dae reload
