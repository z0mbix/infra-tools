.DEFAULT_GOAL := help

## Ubuntu
validate-ubuntu: ## Validate packer configuration
	packer validate --var-file common.pkrvar.hcl --var-file ubuntu-2204.pkrvar.hcl .

build-ubuntu: validate-ubuntu ## Build AMI
	packer build --var-file common.pkrvar.hcl --var-file ubuntu-2204.pkrvar.hcl .

## RedHat
validate-redhat: ## Validate packer configuration
	packer validate --var-file common.pkrvar.hcl --var-file redhat-9.pkrvar.hcl .

build-redhat: validate-redhat ## Build AMI
	packer build --var-file common.pkrvar.hcl --var-file redhat-9.pkrvar.hcl .

## Rocky
validate-rocky: ## Validate packer configuration
	packer validate --var-file common.pkrvar.hcl --var-file rocky-9.pkrvar.hcl .

build-rocky: validate-rocky ## Build AMI
	packer build --var-file common.pkrvar.hcl --var-file rocky-9.pkrvar.hcl .

help: ## See all the Makefile targets
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: validate-ubuntu build-ubuntu validate-redhat build-redhat validate-rocky build-rocky help
