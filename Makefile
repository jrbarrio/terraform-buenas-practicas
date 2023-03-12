clean:
	@rm -f tfplan
	@rm -fR .terraform
	@rm -f .terraform.lock.hcl
	@rm -f terraform.tfstate
	@rm -f terraform.tfstate.backup
	@rm -f *.zip
	@rm -fR build

init: clean
	@terraform init

plan: init
	@terraform plan -out tfplan -var-file="tfvars/dev.tfvars"

apply:
	@terraform apply -auto-approve tfplan
	@rm tfplan

destroy: init
	@terraform destroy