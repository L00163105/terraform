resource "aws_instance" "jump_box" {
  ami           = "ami-0a3f5ff1cb905da33"
  instance_type = "t2.micro"
  key_name      = "lyit_key"

  subnet_id              = aws_subnet.pub_subnet.id
  vpc_security_group_ids = [aws_security_group.general_sg.id, aws_security_group.bastion_sg.id]

  tags = {
    Name  = var.iam_cdc_lyit
    Owner = var.owner_name
    proj  = "phoenix"
  }
}

resource "aws_instance" "app_instance" {
  ami           = "ami-0a3f5ff1cb905da33"
  instance_type = "t2.micro"
  key_name      = "lyit_key"

  subnet_id              = aws_subnet.pub_subnet.id
  vpc_security_group_ids = [aws_security_group.general_sg.id, aws_security_group.app_sg.id]

  tags = {
    Name  = var.iam_cdc_lyit
    Owner = var.owner_name
    proj  = "phoenix"
  }
}

resource "aws_instance" "mgmt_instance" {
  ami           = "ami-0a3f5ff1cb905da33"
  instance_type = "t2.micro"
  key_name      = "lyit_key"

  subnet_id              = aws_subnet.prv_subnet_mgmt.id
  vpc_security_group_ids = [aws_security_group.general_sg.id, aws_security_group.app_sg.id]

  tags = {
    Name  = var.iam_cdc_lyit
    Owner = var.owner_name
    proj  = "phoenix"
  }
}

resource "aws_db_instance" "dbase_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mariadb"
  engine_version         = "10.2.21"
  instance_class         = "db.t2.micro"
  name                   = "lyit_student_db"
  username               = "root"
  password               = "password"
  parameter_group_name   = "mariadb"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  availability_zone      = aws_subnet.prv_subnet_dbase.availability_zone
}