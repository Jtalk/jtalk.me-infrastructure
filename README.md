# Terraform files powering jtalk.me

Structure:
* `root/state/` to create the initial S3 bucket (uses root accounts)
* `root/iam/` to create restricted users for terraform in AWS (uses root accounts)
* `jtalk-me/` to create/update the infrastructure. Uses limited users created by `root/iam/`