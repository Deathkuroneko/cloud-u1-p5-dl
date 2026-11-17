# Configuracion del proveedor AWS
provider "aws" {
    region = "us-east-1" #region donde se deplegaran los recursos
}

#Creamos el security group
resource "aws_security_group" "mi-sg-dl" {
      name = "mi-security-group-terraform"
      description = "para instancias de terraform"
      vpc_id = "vpc-0faef9fe8b4a0ada4"
      #reglas de entrada para ssh
      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      #reglas de salida para http
      egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
    ami = "ami-0c230065b91270bc6" # Amazon Linux
    instance_type = "t2.micro" # tipo
    key_name = "mi-primera-llaves-dl" # el par de llaves
    tags = {
      Name = "MiInstanciaTerraform2" # Nombre de la instancia
    }
    vpc_security_group_ids = [aws_security_group.mi-sg-dl.id] #asignamos el security group a la instancia
}