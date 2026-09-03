.PHONY: help validate bootstrap-ubuntu22 build-ueransim

help:
	@echo "MINI-MOBILE-7 commands:"
	@echo "  make validate       - validate the Linux host prerequisites"
	@echo "  make bootstrap-ubuntu22 - install the lab host prerequisites"
	@echo "  make build-ueransim - build pinned UERANSIM"

validate:
	bash scripts/validate-host.sh

bootstrap-ubuntu22:
	bash scripts/bootstrap-ubuntu22.sh

build-ueransim:
	bash scripts/build-ueransim.sh
