terramate {
  required_version = "0.11.5"
  config {
        
    # Enables the simplified adhoc HCL code generation
    # https://terramate.io/docs/cli/code-generation/tmgen
    experiments = [
      "tmgen"
    ]
  }
}