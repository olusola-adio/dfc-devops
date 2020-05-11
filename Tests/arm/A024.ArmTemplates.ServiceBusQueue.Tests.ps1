# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\ServiceBus\servicebus-queue.json"

Describe "Service Bus Queue Deployment Tests" -Tag "Acceptance" {
  
  Context "When deploying a queue to a Service Bus Namespace" {
    $TemplateParameters = @{
      serviceBusNamespaceName = "dwp-foo-bar-ns"
      queueName               = "a-queue-name"
    }
    $TestTemplateParams = @{
      ResourceGroupName       = $ResourceGroupName
      TemplateFile            = $TemplateFile
      TemplateParameterObject = $TemplateParameters
    }

    It "Should be deployed successfully with just a subscription" {
      $output = Test-AzureRmResourceGroupDeployment @TestTemplateParams
      $output | Should -Be $null
    }

    if ($output) {
      Write-Error $output.Message
    }
  }
}