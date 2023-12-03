output "vpc" {
  value       = aws_vpc.ecs_vpc.id
  description = "VPC ID"
}

output "public_subnet_one" {
  description = "Public Subnet One"
  value       = aws_subnet.public_subnet_one.id
}

output "public_subnet_two" {
  description = "Public Subnet Two"
  value       = aws_subnet.public_subnet_two.id
}