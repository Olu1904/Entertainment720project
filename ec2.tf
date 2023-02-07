resource "aws_instance" "main" {
    ami = data.aws_ssm_parameter.instance_ami.value
    instance_type = "t3.micro"
    key_name = "ooyekanmi1"
    subnet_id = aws_subnet.public[0].id
    vpc_security_group_ids = ["sg-03ed91ce094a46029"]
    tags = {
      "Name" = "entertainment720_${var.default_tags.env}-EC2"
    }
    user_data = base64encode(file("C:/Users/oyeab/OneDrive/Desktop/Project3/user.sh"))
}
output "ec2_ssh_command" {
  value = "ssh -i ooyekanmi1.pem ubuntu@ec2-${replace(aws_instance.main.public_ip, ".", "-")}.compute-1.amazonaws.com"
}
