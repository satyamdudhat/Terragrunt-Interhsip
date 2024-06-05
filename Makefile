ENV ?= dev
TERRAGRUNT_PATH = infrastructure/environments/dev/
_AWS_PROFILES=satyam
_AWS_REGIONS=ap-south-1
_AWS_BUCKETS=satyam-terragrunts
prefix=project-dev
SCRIPTS=infrastructure/scripts

.EXPORT_ALL_VARIABLES:
TF_VAR_aws_profile=$(_AWS_PROFILES)
TF_VAR_aws_region=$(_AWS_REGIONS)
TF_VAR_tf_bucket=$(_AWS_BUCKETS)
TF_VAR_prefix=$(prefix)
AWS_REGIONS1=$(_AWS_REGIONS)
AWS_PROFILES1=$(_AWS_PROFILES)

.PHONY:

tf:
	@tfswitch
	@tgswitch

init plan apply show destroy: tf
	@cd $(TERRAGRUNT_PATH) && terragrunt $@

tftarget:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -target $(resource_id)

tfdestroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -target $(resource_id)

apply-ci:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -auto-approve

image_push:
	@chmod 775 ./$(SCRIPTS)/image_push_code
	@./$(SCRIPTS)/image_push_code

aws_config:
	@chmod 775 ./$(SCRIPTS)/aws_configuration
	@./$(SCRIPTS)/aws_configuration

assign_env:
	@chmod 775 ./$(SCRIPTS)/assign_environment
	@./$(SCRIPTS)/assign_environment

fmt:
	@terraform fmt -check -recursive infrastructure/modules/Api_Gateway/
	@terraform fmt -check -recursive infrastructure/modules/Dynamo_DB/
	@terraform fmt -check -recursive infrastructure/modules/ECR/
	@terraform fmt -check -recursive infrastructure/modules/Lambda_Function/
	@terraform fmt -check -recursive infrastructure/stack/