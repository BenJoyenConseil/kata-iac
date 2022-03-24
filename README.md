# kata-iac

Un Dojo de code pour l'infrastructure

## Point de départ
Le code d'infrastructure de ce repo déploie un serveur apache sur une instance AWS, avec le code html du site de la 
[duckconf](https://www.laduckconf.com/la-duck-conf/programme/)

### Enoncé

1. L'équipe de dev demande un nouvel environnement aux 2 existants. Cet environnement s'appellera stg. Il faudra refactorer le code tout en conservant le bon fonctionnement des 2 environnements existants
2. Le RSSI demande d'avoir un groupe de sécurité pour tous les environnements afin de leur faciliter le monitoring des accès
3. Le dernier objectif sera de faire évoluer le type de VM, actuellement Centos, vers Ubuntu, aussi pour des raisons de sécurité

### Contraintes

* si tu casses un environnement tu as perdu
* tu ne peux pas créer d'instance supplémentaire, n'utilise que celles qui sont présentes
* interdiction de changer de technologie, tu dois modifier l'existant

### Takeways:
* 
* Organiser le repo par unité de déploiement (stack) pour mieux gérer le couplage et les évolutions
* Découper et tester des petites portions pour réduire la boucle de feedback
* Poser un contrat demande de travailler sur l'intention et c'est le moment de se poser les questions de design : je crée, j'ajoute, je duplique, je modifie
* Nommer les choses pour ce qu’elles font / doivent faire met en évidence la cohérence ou l’incohérence des modules. Cela permet de faire émerger plus facilement le design



## Refs
* [Working Efficiently With Legacy Code]()
* [Refactor Monolithic Terraform Configuration](https://learn.hashicorp.com/tutorials/terraform/organize-configuration)

## Solution
Il existe une branche nommée `solution` avec les 12 étapes

## Installation
1. installer terraform
2. Créer un compte sur [AWS](https://aws.amazon.com/fr/premiumsupport/knowledge-center/create-and-activate-aws-account/), le kata utilise de l'infrastructure Free Tiers (gratuit jusqu'à 750h/mois d'instance EC2)
3. Exécuter les [instructions terraform](./terraform/README.md)
4. Ouvrir dans un navigateur l'adresse public de l'instance, exemple : [http://ec2-13-38-96-250.eu-west-3.compute.amazonaws.com/](http://ec2-13-38-96-250.eu-west-3.compute.amazonaws.com/)
