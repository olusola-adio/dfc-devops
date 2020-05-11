# common variables
$ResourceGroupName = "dwp-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-gateway-v2.json"

Describe "App Gateway Deployment Tests" -Tag "Acceptance" {
  
  Context "When an app gateway is deployed with just a single pool" {
    $TemplateParameters = @{
      appGatewayName      = "dfc-foo-bar-ag"
      subnetRef           = "/subscriptions/bcf9fd2c-cdb6-4af1-9890-9c12785ee2f9/resourceGroups/dfc-foo-bar-rg/providers/Microsoft.Network/virtualNetworks/dfc-foo-bar-vnet/subnets/appgateway"
      backendPools        = @( @{
                                  name = "mypool"
                                  fqdn = "foo.example.net"
                            } )
      backendHttpSettings = @( @{
                                  name                       = "myHttpSettings"
                                  port                       = 80
                                  protocol                   = "Http"
                                  hostnameFromBackendAddress = $true
                            } )
      routingRules        = @( @{ #routing rules dont make sense with only one backend but the template does not allow an empty routingrules array due to ARM template limitations
                                  name        = "myroutingrule"
                                  backendPool = "mypool"
                                  backendHttp = "myHttpSettings"
                                  paths       = @( "/dummy/*" )
                            } )
      publicIpAddressId   = "1.2.3.4"
      userAssignedIdentityName = "dwp-test-template-uim"
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

    if ($output) {
      Write-Error $output.Message
    }

  }
}