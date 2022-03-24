.ONESHELL:
SHELL=bash
.SILENT:
.DEFAULT_GOAL:=help

dry-run: ## Simule un terraform apply et affiche l'état cible
	cd terraform/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform plan -var-file=${ENV}/terraform.tfvars


help:
	echo 'usage: make [COMMANDE] ...'
	echo
	echo 'Commandes disponibles:'
	egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'