# Configuracion del proveedor AWS
provider "aws" {
    region = var.region #region donde se deplegaran los recursos
}

#Creamos el security group
resource "aws_security_group" "mi-sg-efs-dl" {
      name = "mi-security-group-terraform-efs"
      description = "para instancias de terraform para efs"
      vpc_id = "vpc-0faef9fe8b4a0ada4"
      #reglas de entrada para ssh
      ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

#Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias" {
      name = "mi-security-group-terraform-efs-instancias"
      description = "para instancias de terraform para efs"
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
      egress {
        from_port = 2049
        to_port = 2049
        protocol = "tpc"
        cidr_blocks = [aws_security_group.mi-sg-efs-dl.id]
      }
}

# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
    ami = var.ami_id # Amazon Linux
    instance_type = var.tipo_instancia # tipo
    key_name = var.nombre_llave # el par de llaves
    security_groups = [ aws_security_group.mi-sg-efs-instancias.name ]
    count = var.cantidad_instancia
    tags = {
      Name = "Mi instancia EFS - ${count.index + 1}" # Nombre de la instancia
    }
    vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] #asignamos el security group a la instancia
}