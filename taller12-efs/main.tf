# Configuracion del proveedor AWS
provider "aws" {
    region = var.region #region donde se deplegaran los recursos
}

#Creamos el security group EFS
resource "aws_security_group" "mi-sg-efs-dl-14" {
      name = "mi-security-group-terraform-efs"
      description = "para instancias de terraform para efs"
      vpc_id = "vpc-0faef9fe8b4a0ada4"
}

#Creamos el security group Instancias
resource "aws_security_group" "mi-sg-efs-instancias-14" {
      name = "mi-security-group-terraform-efs-instancias"
      description = "para instancias de terraform para efs"
      vpc_id = "vpc-0faef9fe8b4a0ada4"
}

# Reglas SG instancias
# Entrada 
# SSH
resource "aws_vpc_security_group_ingress_rule" "ingreso_ssh_instancias" {
    security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_ipv4 = "0.0.0.0/0"
}

# Salida SSH
# salida 2049 y all trafic
resource "aws_vpc_security_group_egress_rule" "salida_efs_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tpc"
  from_port = 2049
  to_port = 2049
  # Referenncio el Desyino que es el EFS
  referenced_security_group_id = aws_security_group.mi-sg-efs-dl-14.id  
}

# Salida a internet
resource "aws_vpc_security_group_egress_rule" "Salida-internet" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = -1
  # from_port = 0
  # to_port = 0
  cidr_ipv4 = "0.0.0.0/0"
}

# Reglas SG EFS

# Entrada
# Entrada 2049
resource "aws_vpc_security_group_ingress_rule" "Entrada-efs" {
  security_group_id = aws_security_group.mi-sg-efs-dl-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  # referencia desde un origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# No se requiere para as reglas de salida

