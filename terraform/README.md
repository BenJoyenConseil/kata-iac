Infra Terraform
===

Ce repo contient du code terraform pour monter le site-web duck-conf

## install
install terraform v1.1.6

## deploiement

    cd terraform/<env>
	terraform init -backend-config=gitlab.tfbackend -backend-config="password=${GITLAB_ACCESS_TOKEN}"
    terraform apply
