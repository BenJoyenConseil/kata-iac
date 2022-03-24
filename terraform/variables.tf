variable "ssh_key" {
  description = "chemin du fichier public de la clé ssh"
  type = string
}

variable "env" {
  description = "le nom de l'environnement"
  type = string
}

variable "sg_name" {
  description = "le nom du groupe de sécurité global"
  type = string
}