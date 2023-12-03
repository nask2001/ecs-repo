resource "aws_ecs_cluster" "ecs_cluster" {
  name = "DemoCluster"

  tags = {
    "Name" = "Demo Cluster" 
  }
}