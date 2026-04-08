resource "aws_launch_template" "repte17_ng" {
  name_prefix = "repte17-ng-"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "repte17-ng"
      Project = "repte17"
      Owner   = "Richi"
    }
  }
}
