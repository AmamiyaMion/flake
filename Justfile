SUDO_COMMAND := "sudo"
default: pull update rebuild

rebuild:
	{{SUDO_COMMAND}} nixos-rebuild switch --flake .
switch: rebuild
r: rebuild

boot:
    {{SUDO_COMMAND}} nixos-rebuild boot --flake .
b: boot

update:
	nix flake update
u: update
up: update

gc:
    {{SUDO_COMMAND}} nix-collect-garbage -d
clean: gc
c: gc

optimise:
    nix store optimise
optimize: optimise

search +args:
    nix search nixpkgs {{args}}
se +args: (search args)
sr +args: (search args)
s +args: (search args)

commit msg +files:
	git add {{files}}
	git commit -s -m '{{msg}}'

commit-all msg:
	git add -A
	git commit -s -m '{{msg}}'

push:
	git push

pull:
    git pull

noproxy:
    {{SUDO_COMMAND}} dae suspend
npx: noproxy

proxy:
    {{SUDO_COMMAND}} dae reload
px: proxy
