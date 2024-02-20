deploy:
ifdef env
	sudo nixos-rebuild switch --flake .#$(env)
else
	sudo nixos-rebuild switch --flake .#work
endif

debug:
ifdef env
	sudo nixos-rebuild switch --flake .#$(env) --show-trace --verbose
else
	sudo nixos-rebuild switch --flake .#work --show-trace --verbose
endif

update:
	sudo nix flake update

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 30d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
