ENV ?= prod
TERRAGRUNT_PATH = infrastructure/environments/prod/
_AWS_PROFILES=satyam
_AWS_REGIONS=ap-south-1
_AWS_BUCKETS=satyam-terragrunts
# TERRAFORM_VERSION = 1.8.3
# TERRAGRUNT_VERSION = 0.58.4
prefix=project-prod


.EXPORT_ALL_VARIABLES:
TF_VAR_aws_profile=$(_AWS_PROFILES)
TF_VAR_aws_region=$(_AWS_REGIONS)
TF_VAR_tf_bucket=$(_AWS_BUCKETS)
TF_VAR_prefix=$(prefix)

# Install and set a Terraform and Terragrunt version
# install-tf-tg:
# 	@tfenv install $(TERRAFORM_VERSION)
# 	@tgenv install $(TERRAGRUNT_VERSION)

tf:
	@tfswitch
	@tgswitch


# Terragrunt Command
init plan apply show destroy: tf
	@cd $(TERRAGRUNT_PATH) && terragrunt $@

tftarget:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -target $(resource_id)

tfdestroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -target $(resource_id)

apply-ci:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -auto-approve

destroy-ci:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -auto-approve

ecr-repo:
		@cd $(TERRAGRUNT_PATH) && terragrunt apply -auto-approve 
