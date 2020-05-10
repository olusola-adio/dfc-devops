# common variables
$ResourceGroupName = "olu-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-service.json"

Describe "App Service Deployment Tests" -Tag "Acceptance" {
  
  Context "When app service is deployed with just name and ASP" {
    $TemplateParameters = @{
      appServiceName     = "dfc-foo-bar-as"
      appServicePlanName = "olu-test-template-asp"
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
      appServiceName     = "dfc-foo-bar-fa"
      appServicePlanName = "olu-test-template-asp"
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