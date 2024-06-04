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

ecr-repo:
		@cd $(TERRAGRUNT_PATH) && terragrunt apply -auto-approve 

image_push:
	 @bash $(SCRIPTS)/image_push_code.sh