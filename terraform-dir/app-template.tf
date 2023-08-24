resource "aws_launch_template" "app" {
  name_prefix = "app"
  image_id = "ami-0557a15b87f6559cf" 
  instance_type = var.app_instance_type
  network_interfaces {
    security_groups = [ "${aws_security_group.app_sg.id}" ]

    associate_public_ip_address = true
  }
  
  user_data = "${base64encode(file("launch-data/app-data.sh"))}"
  lifecycle {
      create_before_destroy = true
    }
}