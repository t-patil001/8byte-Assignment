first comment out backend.tf and then terraform init and terraform plan -var-file=dev.tfvars

and then uncommit it - terraform init -migrate-state

yes



aws ecr get-login-password --region us-east-1 \
| docker login \
--username AWS \
--password-stdin 579083551077.dkr.ecr.us-east-1.amazonaws.com

inside server (change last line)


destroy =  terraform destroy -var-file=dev.tfvars