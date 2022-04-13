# aws_iam_role.dynatrace:
resource "aws_iam_role" "dynatrace" {

  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Condition = {
            StringEquals = {
              "sts:ExternalId" = "7e0c42b0-5ba0-43ee-9785-99eb5d32c2e2"
            }
          }
          Effect = "Allow"
          Principal = {
            AWS = [
              "arn:aws:iam::375002761141:role/Dynatrace_ActiveGate_role",
              "arn:aws:iam::509560245411:root",
            ]
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = false
  managed_policy_arns   = []
  max_session_duration  = 3600
  name                  = "DynatraceMonitoringRole"
  path                  = "/"
  tags                  = {}
  tags_all              = {}

  inline_policy {
    name = "DynatraceMonitoringPolicy"
    policy = jsonencode(
      {
        Statement = [
          {
            Action = [
              "acm-pca:ListCertificateAuthorities",
              "apigateway:GET",
              "apprunner:ListServices",
              "appstream:DescribeFleetqs",
              "appsync:ListGraphqlApis",
              "athena:ListWorkGroups",
              "autoscaling:DescribeAutoScalingGroups",
              "cloudformation:ListStackResources",
              "cloudfront:ListDistributions",
              "cloudhsm:DescribeClusters",
              "cloudsearch:DescribeDomains",
              "cloudwatch:GetMetricData",
              "cloudwatch:GetMetricStatistics",
              "cloudwatch:ListMetrics",
              "codebuild:ListProjects",
              "datasync:ListTasks",
              "dax:DescribeClusters",
              "directconnect:DescribeConnections",
              "dms:DescribeReplicationInstances",
              "dynamodb:ListTables",
              "dynamodb:ListTagsOfResource",
              "ec2:DescribeAvailabilityZones",
              "ec2:DescribeInstances",
              "ec2:DescribeNatGateways",
              "ec2:DescribeSpotFleetRequests",
              "ec2:DescribeTransitGateways",
              "ec2:DescribeVolumes",
              "ec2:DescribeVpnConnections",
              "ecs:ListClusters",
              "eks:ListClusters",
              "elasticache:DescribeCacheClusters",
              "elasticbeanstalk:DescribeEnvironmentResources",
              "elasticbeanstalk:DescribeEnvironments",
              "elasticfilesystem:DescribeFileSystems",
              "elasticloadbalancing:DescribeInstanceHealth",
              "elasticloadbalancing:DescribeListeners",
              "elasticloadbalancing:DescribeLoadBalancers",
              "elasticloadbalancing:DescribeRules",
              "elasticloadbalancing:DescribeTags",
              "elasticloadbalancing:DescribeTargetHealth",
              "elasticmapreduce:ListClusters",
              "elastictranscoder:ListPipelines",
              "es:ListDomainNames",
              "events:ListEventBuses",
              "firehose:ListDeliveryStreams",
              "fsx:DescribeFileSystems",
              "gamelift:ListFleets",
              "glue:GetJobs",
              "inspector:ListAssessmentTemplates",
              "kafka:ListClusters",
              "kinesis:ListStreams",
              "kinesisanalytics:ListApplications",
              "kinesisvideo:ListStreams",
              "lambda:ListFunctions",
              "lambda:ListTags",
              "lex:GetBots",
              "logs:DescribeLogGroups",
              "mediaconnect:ListFlows",
              "mediaconvert:DescribeEndpoints",
              "mediapackage-vod:ListPackagingConfigurations",
              "mediapackage:ListChannels",
              "mediatailor:ListPlaybackConfigurations",
              "opsworks:DescribeStacks",
              "qldb:ListLedgers",
              "rds:DescribeDBClusters",
              "rds:DescribeDBInstances",
              "rds:DescribeEvents",
              "rds:ListTagsForResource",
              "redshift:DescribeClusters",
              "robomaker:ListSimulationJobs",
              "route53:ListHostedZones",
              "route53resolver:ListResolverEndpoints",
              "s3:ListAllMyBuckets",
              "sagemaker:ListEndpoints",
              "sns:ListTopics",
              "sqs:ListQueues",
              "storagegateway:ListGateways",
              "sts:GetCallerIdentity",
              "swf:ListDomains",
              "tag:GetResources",
              "tag:GetTagKeys",
              "transfer:ListServers",
              "workmail:ListOrganizations",
              "workspaces:DescribeWorkspaces",
            ]
            Effect   = "Allow"
            Resource = "*"
            Sid      = "DynatraceReadOnlyAccess"
          },
        ]
        Version = "2012-10-17"
      }
    )
  }
}
