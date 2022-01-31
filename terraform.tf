provider "aws" {
	  region = "us-east-2"
	}
	resource "aws_instance" "myec2" {
	  depends_on = [aws_db_instance.default]
	  ami           = "ami-04505e74c0741db8d"
	  instance_type = "t2.micro"
	  subnet_id   = "subnet-049b97e1d7c38467c"
	  key_name = "sshkey1"
	  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint})
	  iam_instance_profile = "demo"
	  security_groups = ["sg-052b7d954440d8def"]
	  tags = {
	    Name = "cpms"
	  }
	}
	resource "aws_db_instance" "default" {
	  allocated_storage    = 10
	  engine               = "mysql"
	  engine_version       = "5.7"
	  instance_class       = "db.t2.micro"
	  name                 = "cpms"
	  identifier           = "myrds"
	  username             = "admin"
	  password             = "arvind123"
	  parameter_group_name = "default.mysql5.7"
	  skip_final_snapshot  = true
	  publicly_accessible  = true
	  vpc_security_group_ids = ["sg-052b7d954440d8def"]
	}
