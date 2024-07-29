output "instance_public_ip" {
  description = "the public ip address of ec2 instance"
  value = aws_instance.Ngnix.public_ip
}


output "instance_url" {
    description = "aws ec2 instance http url"
    value = "http://${aws_instance.Ngnix.public_ip}"
  
}
  