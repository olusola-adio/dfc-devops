# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-service.json"

Describe "App Service Deployment Tests" -Tag "Acceptance" {
  
  Context "When app service is deployed with just name and ASP" {
    $TemplateParameters = @{
      appServiceName     = "dwp-foo-bar-as"
      appServicePlanName = "dwp-test-template-asp"
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

  Context "When app service is deployed as a function app" {
    $TemplateParameters = @{
      appServiceName     = "dwp-foo-bar-fa"
      appServicePlanName = "dwp-test-template-asp"
      appServiceType     = "functionapp"
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