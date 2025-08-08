resource "aws_iam_role" "primary" {
  name = "eks-cluster"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })

}

resource "aws_iam_policy" "ebs_policy" {
  name        = "CustomEBSFullAccess"
  description = "Custom policy for EBS full access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateVolume",
          "ec2:DeleteVolume",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:DescribeVolumes",
          "ec2:ModifyVolume"
        ]
        Resource = "*"
      }
    ]
  })

}

resource "aws_iam_role" "secondary" {
  name = "eks-cluster-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

}

resource "aws_iam_policy" "eks_autoscaler_policy" {
  name        = "eks-autoscaler-policy"
  description = "Allows EKS nodes to interact with Auto Scaling"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"
      Action = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:DescribeTags",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "role_one" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.primary.name
}

resource "aws_iam_role_policy_attachment" "role_two" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.primary.name
}

resource "aws_iam_role_policy_attachment" "role_three" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.secondary.name
}

resource "aws_iam_role_policy_attachment" "role_four" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.secondary.name
}

resource "aws_iam_role_policy_attachment" "role_five" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.secondary.name
}

resource "aws_iam_role_policy_attachment" "role_six" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.secondary.name
}

resource "aws_iam_role_policy_attachment" "role_seven" {
  policy_arn = aws_iam_policy.ebs_policy.arn
  role       = aws_iam_role.primary.name
}

resource "aws_iam_role_policy_attachment" "role_eight" {
  policy_arn = aws_iam_policy.ebs_policy.arn
  role       = aws_iam_role.secondary.name
}

resource "aws_iam_role_policy_attachment" "role_nine" {
  policy_arn = aws_iam_policy.eks_autoscaler_policy.arn
  role       = aws_iam_role.secondary.name
}