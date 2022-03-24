.ONESHELL:
SHELL=bash
.SILENT:
.DEFAULT_GOAL:=help

dry-run: ## Simule un terraform apply et affiche l'état cible
	cd terraform/${ENV}/
	terraform init -backend-config=gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
	terraform plan


help:
	echo 'usage: make [COMMANDE] ...'
	echo
	echo 'Commandes disponibles:'
	egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'