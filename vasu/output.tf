output "iam_user_key" {
  value = aws_iam_access_key.iam-key
  sensitive = true
}

output "pub_ip" {
  value = aws_instance.ec2.public_ip
  
}

output "test" {
  value = aws_instance.ec2.security_groups
  
}

output "test-2" {
  value = aws_instance.ec2.key_name
  
}

output "test-3" {
  value = aws_instance.ec2.private_ip
  
}

output "test-4" {
  value = aws_instance.ec2.vpc_security_group_ids
  
}

output "test-5" {
  value = aws_instance.ec2.public_dns
  
}

output "test-6" {
  value = aws_instance.ec2.subnet_id
  
}
