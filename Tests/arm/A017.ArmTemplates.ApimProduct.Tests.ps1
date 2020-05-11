# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\APIM\apim-product.json"

Describe "Apim Service Deployment Tests" -Tag "Acceptance" {
  
    Context "When APIM product is deployed with just apimServiceName and productDisplayName" {
        $TemplateParameters = @{
            apimServiceName         = "dwp-foo-bar-apim"
            productDisplayName      = "Bar Api"
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