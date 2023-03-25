clean:
	@rm -f tfplan
	@rm -fR .terraform
	@rm -f .terraform.lock.hcl
	@rm -f terraform.tfstate
	@rm -f terraform.tfstate.backup
	@rm -f *.zip
	@rm -fR build
	@rm -f tfsec.txt
	@rm -f infracost.txt

init: clean
	@terraform init

format: init
	@terraform fmt

validate: format
	@terraform validate

tfsec: validate
	@tfsec .

plan: validate
	@terraform plan -out tfplan -var-file="tfvars/dev.tfvars"
	tfsec . --soft-fail --out tfsec.txt --format text 
	infracost auth login
	infracost diff --path tfplan --out-file infracost.txt --format diff

apply:
	@terraform apply -auto-approve tfplan
	@rm tfplan

destroy: init
	@terraform destroy