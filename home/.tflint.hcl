# https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md

tflint {
  required_version = ">= 0.50"
}

config {
  format = "compact"
  call_module_type = "local"
  force = false
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
    enabled = true
    version = "0.38.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_naming_convention" {
  enabled = true
  format = "snake_case"
}
