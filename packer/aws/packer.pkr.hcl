packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }

  required_plugins {
    git = {
      version = ">= 0.3.2"
      source  = "github.com/ethanmdavidson/git"
    }
  }
}
