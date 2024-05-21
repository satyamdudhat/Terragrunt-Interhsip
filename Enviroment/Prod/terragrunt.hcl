include {
  path = find_in_parent_folders("comman.hcl")
}

terraform{
    source = "../../"


extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    required_var_files = ["terraform.tfvars"]

}

}
