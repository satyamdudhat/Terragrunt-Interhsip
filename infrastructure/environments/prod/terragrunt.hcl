include {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
    source = "../..//stack/"

extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    // required_var_files = ["terraform.tfvars"]

}

}
