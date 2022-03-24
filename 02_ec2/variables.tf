variable "ssh_key" {
  description = "chemin du fichier public de la clé ssh"
  type        = string
}

variable "env" {
  description = "le nom de l'environnement"
  type        = string
}

variable "sg_name" {
  description = "le nom du groupe de sécurité global"
  type        = string
}

variable "apache_config_gitpath" {
  description = "Le chemin qui pointe vers la conf apache de l'envrionnement"
  type        = string
}