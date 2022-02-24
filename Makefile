build:
	ansible-galaxy collection build --force
publish: build
	@[ -e .env ] && source .env; \
	ansible-galaxy collection publish wenerme-alpine-$(shell yq r galaxy.yml version).tar.gz --api-key $$API_KEY

lint:
	docker run --rm -h toolset -it -v $(PWD):/host -w /host quay.io/ansible/toolset ansible-lint

ci: lint
