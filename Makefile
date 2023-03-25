clean:
	@rm -fR .terraform
	@rm -f .terraform.lock.hcl
	@rm -f terraform.tfstate
	@rm -f terraform.tfstate.backup
	@rm -f *.zip
	@rm -fR build
	@rm -fR tmp

init: clean
	@terraform init

format: init
	@terraform fmt

validate: format
	@terraform validate

tfsec: validate
	@tfsec .

plan: validate
	@mkdir -p tmp
	@terraform plan -out tmp/tfplan -var-file="tfvars/dev.tfvars"
	@tfsec . --soft-fail --out tmp/tfsec.txt --format text 
	@infracost auth login
	@infracost breakdown --path . --format table --out-file tmp/infracost.txt

apply:
	@terraform apply -auto-approve tmp/tfplan
	@rm tfplan

destroy: init
	@terraform destroy