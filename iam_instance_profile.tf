resource "aws_iam_role" "ec2_role" {
  name               = "EC2InstanceRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "Ansible_EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

data "aws_iam_policy_document" "ec2_vpc_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*",
      "vpc:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_vpc_policy" {
  name   = "EC2VPCPolicy"
  policy = data.aws_iam_policy_document.ec2_vpc_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_vpc_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_vpc_policy.arn
}

