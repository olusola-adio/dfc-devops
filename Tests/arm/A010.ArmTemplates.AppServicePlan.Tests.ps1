# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-service-plan.json"

Describe "App Service Plan Deployment Tests" -Tag "Acceptance" {
  
  Context "When an app service plan is deployed with just name" {
    $TemplateParameters = @{
      appServicePlanName = "dwp-foo-bar-asp"
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