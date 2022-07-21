provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "redhat_server" {
  ami = "ami-06640050dc3f556bb"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_ssh.name]
  key_name = aws_key_pair.ansible_key.key_name
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "install_jdk1_8.sh"
    destination = "/tmp/instal_jdk1_8.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/instal_jdk1_8.sh",
      "/tmp/script.sh",
    ]
  }
  tags = {
    Name = "ExampleRedHatServer"
  }
}

resource "aws_key_pair" "ansible_key" {
  key_name = "my_tf_key"
  public_key = file("./ssh_keys/ansible_key.pub")
}

resource "aws_security_group" "web_ssh" {
  name = "web_ssh_sg"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
