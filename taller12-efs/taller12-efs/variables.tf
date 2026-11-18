# Region donde se desplegarán los recursos
variable "region" {
    description = "the AWS region"
    type = string
    default = "us-east-1"       
}

variable "ami_id" {
    description = "value"
    type = string
    default = "ami-0c230065b91270bc6"  # Amazon Linux
}

variable "tipo_instancia" {
    description = "Tipo de Instancia"
    type = string
    default = "t2.micro"
}

variable "nombre_llave" {
    description = "Nombre de par de llaves"
    type = string
    default = "mi-primera-llaves-dl"
}

variable "cantidad_instancia" {
    description = "Cantidad de instancias"
    type = number
    default = 2
}