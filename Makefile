_ENV=dev
TERRAGRUNT_PATH=infrastructure/environments/$(_ENV)/

tf:
	@tfswitch
	@tgswitch

init plan apply show destroy: tf
	@cd $(TERRAGRUNT_PATH) && terragrunt $@


tftarget:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -target $(resource_id)

tfdestroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -target $(resource_id)

