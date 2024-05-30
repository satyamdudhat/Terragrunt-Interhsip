ENV ?= dev
_AWS_PROFILE=satyam
_AWS_REGION=ap-south-1
_AWS_BUCKET=satyam-terragrunts

.EXPORT_ALL_VARIABLES:
TF_VAR_aws_profile=$(_AWS_PROFILE)
TF_VAR_aws_region=$(_AWS_REGION)
TF_VAR_tf_bucket=$(_AWS_BUCKET)

# Check Which Environment is using 
ifeq ($(ENV),dev)
    TERRAGRUNT_PATH = infrastructure/environments/dev/
	TERRAFORM_VERSION = 1.8.3
  	TERRAGRUNT_VERSION = 0.58.4
else ifeq ($(ENV),prod)
    TERRAGRUNT_PATH = infrastructure/environments/prod/
	TERRAFORM_VERSION = 1.8.3
  	TERRAGRUNT_VERSION = 0.58.4
else
    $(error Unknown environment: $(ENV))
endif

# Install and set a Terraform and Terragrunt version
install-tf-tg:
	@tfenv install $(TERRAFORM_VERSION)
	@tgenv install $(TERRAGRUNT_VERSION)

set-tf-tg-version: install-tf-tg
	@tfenv use $(TERRAFORM_VERSION)
	@tgenv use $(TERRAGRUNT_VERSION)

# Terragrunt Command
init plan apply show destroy: set-tf-tg-version
	@cd $(TERRAGRUNT_PATH) && terragrunt $@

tftarget:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -target $(resource_id)

tfdestroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -target $(resource_id)
