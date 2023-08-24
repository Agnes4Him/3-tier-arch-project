resource "aws_launch_template" "web" {
  name_prefix = "web"
  image_id = "ami-0557a15b87f6559cf" 
  instance_type = var.web_instance_type
  network_interfaces {
    security_groups = [ "${aws_security_group.web_sg.id}" ]

    associate_public_ip_address = true
  }
  
  user_data = "${base64encode(file("launch-data/web-data.sh"))}"
  lifecycle {
      create_before_destroy = true
    }
}