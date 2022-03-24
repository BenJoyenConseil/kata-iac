.ONESHELL:
SHELL=bash
.SILENT:
.DEFAULT_GOAL:=help

dry-run-ec2: ## Simule un terraform apply et affiche l'état cible
	cd 02_ec2/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform plan -var-file=${ENV}/terraform.tfvars

deploy-io: ## Déploie la stack d'entrées/sorties
	cd 01_io/
	rm -rf .terraform
	terraform init -backend-config=gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform apply

deploy-ec2: ## Déploie la stack EC2
	cd 02_ec2/
	rm -rf .terraform
	terraform init -backend-config=${ENV}/gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform apply -var-file="${ENV}/terraform.tfvars"

help:
	echo 'usage: make [COMMANDE] ...'
	echo
	echo 'Commandes disponibles:'
	egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'