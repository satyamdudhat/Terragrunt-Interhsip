ENV ?= dev
TERRAGRUNT_PATH = infrastructure/environments/dev/
_AWS_PROFILE=satyam
_AWS_REGION=ap-south-1
_AWS_BUCKET=satyam-terragrunts
PREFIX=project-dev
SCRIPTS=infrastructure/scripts
GITHUB_COMMIT_HASH=$(shell git rev-parse HEAD)

.EXPORT_ALL_VARIABLES:
TF_VAR_aws_profile=$(_AWS_PROFILE)
TF_VAR_aws_region=$(_AWS_REGION)
TF_VAR_tf_bucket=$(_AWS_BUCKET)
TF_VAR_prefix=$(PREFIX)


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

build-push:
	@./$(SCRIPTS)/build_push

aws_config:
	@./$(SCRIPTS)/aws_configuration

image-build:
	@docker build -t "$(PREFIX)" .

