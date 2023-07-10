build:
	ansible-galaxy collection build --force
publish: build
	@[ -e .env ] && source .env; \
	ansible-galaxy collection publish wenerme-alpine-$(shell yq r galaxy.yml version).tar.gz --api-key $$API_KEY

lint:
	docker run --rm -h toolset -v $(PWD):/host -w /host quay.io/ansible/creator-ee ansible-lint

dev:
	@#docker run --rm -h toolset --entrypoint bash -it -v $(PWD):/host -w /host registry.cn-hongkong.aliyuncs.com/cmi/ansible_creator-ee
	docker run --rm -h toolset --entrypoint bash -it -v $(PWD):/host -w /host quay.io/ansible/toolset

ci: lint
