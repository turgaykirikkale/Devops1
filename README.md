# Devops1 (TERRAFORM AND AWS)
 -1 VPC ,
 -2 SUBNET ==> 1 PRIVATE AND 1 PUBLIC
 -2 EC2    ==> 1 INSIDE OF PRIVATE SUBNET- 1 INSIDE # OF PUBLIC SUBNET

 -INTERNET GATEWAY => An Internet Gateway (IGW) is a network component in AWS that acts as a bridge between a Virtual Private Cloud (VPC) and the internet. With an Internet Gateway, resources within the VPC can be accessed from the internet and those resources can also communicate with the internet.


 -NAT GATEWAY (Network Address Translation Gateway), =>  is a network component used in AWS within a Virtual Private Cloud (VPC) to enable the outbound traffic of resources (such as EC2 instances) located in private subnets to the internet or other AWS services. NAT Gateway allows these resources to send data out while preventing unwanted inbound traffic from reaching them.


 -ROUTE TABLE =>A Route Table in AWS is a configuration file that determines how network traffic within a Virtual Private Cloud (VPC) is routed. Each route table contains a set of rules (routes) that specify which router the network traffic within the VPC will pass through. Route tables are associated with subnets within the VPC to define how the resources in those subnets can reach destinations such as the internet, other subnets, or gateways.


 -IAM ==>AWS Identity and Access Management (IAM) is a service that allows you to securely manage access to AWS services and resources. With IAM, you can create users and groups, and assign them specific permissions to access certain resources. IAM enables you to centrally manage authentication and authorization, allowing you to control who can do what in your AWS environment.

 ---IAM Role ==>An IAM Role is an identity management tool used to provide temporary access to AWS services or resources. IAM roles are created to grant temporary         permissions to entities (such as another AWS service, user, or application) that do not have IAM usernames and passwords.

 ---IAM Policy ==> An IAM Policy is a JSON document that specifies what actions can be performed on AWS resources under which conditions. This document defines the permissions between identities (users, groups, roles) and resources (such as S3, EC2, Lambda, etc.).
        Features of an IAM Policy:

        JSON Format: Policy documents are written in JSON format and consist of components such as Version, Statement, Effect, Action, and Resource.

        Effect: The policy contains either an Allow (grant) or Deny (reject) effect, which determines whether a specific action is permitted or not.

        Action: This defines which actions (e.g., s3:ListBucket, ec2:StartInstances) can be performed.

        Resource: This specifies which AWS resources the policy applies to, such as a specific S3 bucket or EC2 instance.

        Condition: Additional rules that specify under what conditions the permissions are valid. For example, access may be granted from a specific IP address or allowed during a specific time.

-S3 ==> Amazon S3 (Simple Storage Service) is an object storage service offered by AWS. It provides developers and businesses with the ability to securely store, manage, and analyze their data. S3 is scalable and offers high availability and durability, making it an ideal solution for storing large amounts of data.