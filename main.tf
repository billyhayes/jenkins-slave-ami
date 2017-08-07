provider "aws" {
  region = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_instance" "jenkins_slave" {
  ami = "ami-22ce4934"
  instance_type = "m4.large"
  key_name = "KEYNAME"
  security_groups = ["jenkins"]

  tags {
    Name = "jenkins_slave_ami"
  }

  provisioner "file" {
    source      = "jenkins_slave.sh"
    destination = "/tmp/jenkins_slave.sh"
    connection {
      timeout = "5m"
      user = "ec2-user"
      private_key = "${file("~/path/to/keys/key.pem")}"
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins_slave.sh",
      "/tmp/jenkins_slave.sh",
    ]
    connection {
      timeout = "5m"
      user = "ec2-user"
      private_key = "${file("~/path/to/keys/key.pem")}"
    }
  }

}

resource "aws_ami_from_instance" "jenkins_slave" {
    name = "jenkins_slave"
    description = "Testing Terraform aws_ami_from_instance resource"
    source_instance_id = "${aws_instance.jenkins_slave.id}"
}
