# 3-tier-arch-project

This is a Infrastructure as Code/ Cloud (AWS) project that demonstrates the deployment of a highly available, scalable and secured infrastructure.

Components include Application load balancers (internet-facing, and internal), a frontend-facing web application, a backend application for logic processing, and an RDS MySQL database, which the backend communicates with.

The web tier of the architecture is deployed in a public subnet, while the app and data tiers are in the private subnets.

Other components include an Autoscaling group, to dynamically scale out infrastructures.
