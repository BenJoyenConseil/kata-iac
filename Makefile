.ONESHELL:
SHELL=bash
.SILENT:
.DEFAULT_GOAL:=help

dry-run: ## Simule un terraform apply et affiche l'état cible
	cd terraform/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform plan -var-file=${ENV}/terraform.tfvars

deploy-io: ## Déploie la stack d'entrées/sorties
	cd 01_io/
	rm -rf .terraform
	terraform init -backend-config=gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform apply

deploy-ec2: ## Déploie la stack EC2
	cd terraform/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform apply -var-file="${ENV}/terraform.tfvars"

status: ## Affiche l'état du siteweb et son code HTTP
	cd terraform/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	url=$$(terraform output -raw dns)
	echo "web server url : $${url}"
	curl -I $${url} --user oie:oie

help:
	echo 'usage: make [COMMANDE] ...'
	echo
	echo 'Commandes disponibles:'
	egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'