# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\keyvault.json"

Describe "Key Vault Deployment Tests" -Tag "Acceptance" {
  
  Context "When KeyVault deployed with just key vault name" {
    $TemplateParameters = @{
      keyVaultName = "dwp-foo-bar-kv"
    }
    $TestTemplateParams = @{
      ResourceGroupName       = $ResourceGroupName
      TemplateFile            = $TemplateFile
      TemplateParameterObject = $TemplateParameters
    }

    $output = Test-AzureRmResourceGroupDeployment @TestTemplateParams
  
    It "Should be deployed successfully" {
      $output | Should -Be $null
    }

  }
}