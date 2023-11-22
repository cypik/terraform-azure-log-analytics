# terraform-azure-log-analytics
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This repository contains Terraform code to deploy resources on Microsoft Azure, including a resource group and a azure-log-analytics.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Example

```hcl
module "log-analytics" {
  source                           = "git::https://github.com/opz0/terraform-azure-log-analytics.git?ref=v1.0.0"
  name                             = "app"
  environment                      = "test"
  resource_group_name              = module.resource_group.resource_group_name
  log_analytics_workspace_location = module.resource_group.resource_group_location
}
```
This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
The following input variables can be configured:

- 'name': Specifies the name of the Log Analytics Workspace.
- 'resource_group_name': The name of the resource group in which the Log Analytics workspace is created.
- 'location':  Specifies the supported Azure location where the resource exists.
- 'sku': Specifies the SKU of the Log Analytics Workspace.

## Module Outputs
- 'id': The Log Analytics Workspace ID.
- 'workspace_id': The Workspace (or Customer) ID for the Log Analytics Workspace.

# Examples
For detailed examples on how to use this module, please refer to the 'examples' directory within this repository.

# License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/opz0/terraform-azure-log-analytics/blob/master/LICENSE) file for more details.

# Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
