## 1.Terraform Resource Dependency 
```bash
resource "aws_security_group" "main"{
name = "example"
}

resource "aws_instance" "main"{
ami = "ami-abc"
instance_type = "t2.small"

depends_on = [aws_security_group.main]
}

# Instance will be created after Security group.
```

## 2.Terraform Lifecycle
```bash
resource "aws_instance" "main"{
ami = "ami-abc"
instance_type = "t2.small"

lifecycle {
        create_before_destroy = true    # create a new the destory old resource
        prevent_destroy = true          # resource can't be destroyed
        
        ignore_chages = [ password_length, password_reset_required ]   # NO new resource created on these changes
        
        replace_triggered_by = [ aws_security_group.main, aws_security_group.main.ingress ]
        # New resource created if these are changed.

        post
    }

}

```

## 3.Terraform validation
- depends_on allows to check only if resource created/exists or not 
- with validation one can check state

```bash
# Pre-condition for S3 bucket name check
lifecycle{
    precondition { 
        condition = var.bucket_name != ""
        error_message = "Bucket name cannot be empty"
    }
}
```
```bash
# Post-condition for checking Public IP of EC2
lifecycle{
    postcondition { 
        condition = self.public_ip != ""
        error_message = "Instnce must have Public IP after instance creation"
    }
}
```

## 4.State Manipulation

```bash
terraform state list    # List all resources in the state

terraform state show <resource_address>     # Show details of a specific resource

terraform state mv <source_address> <destination_address>     # move / rename state of resource

terraform state rm <resource_address>       # Remove resource from state / tf won't manage

terraform state pull    # Pull the current state
terraform state push <state_file>  # Push a local state file to the remote backend

terraform state    # List all state commands

terraform apply -refresh-only        # Refresh the state of terraform.

```

## 5.Terraform Import
Import existing infrastructure resources into Terraform state
- You have already created an EC2 instance (manually).
- Create a resource block in tf config (initially you can keep it empty)
- Use terraform import command `terraform import aws_instance.main ec2_id`
- Terraform show to inspect the imported resource.
- Update the resource block accordingly.

## 6.WorkSpace
- Allows you to manage multiple sets of infrastructure configurations within a single configuration directory.
- Each workspace has its own state file

```bash
terraform workspace list        # Listing Workspaces

terraform workspace show        # Show Current Workspace

terraform workspace new <workspace_name>        # Creating a Workspace

terraform workspace select <workspace_name>     # Selecting a Workspace


terraform workspace select default              # Deleting a Workspace
terraform workspace delete <workspace_name>

```

## 7.Terraform Cloud

- Managed service provided by HashiCorp that facilitates collaboration on Terraform configurations.

- Providing features like
    - remote state management,
    - version control system (VCS) integration,
    - automated runs, and
    - secure variable management.
