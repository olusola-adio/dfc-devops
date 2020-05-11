# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\application-insights.json"

Describe "App Service Plan Deployment Tests" -Tag "Acceptance" {
  
  Context "When application insights is deployed with just name" {
    $TemplateParameters = @{
      appInsightsName = "dwp-foo-bar-ai"
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