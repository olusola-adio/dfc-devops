# common variables
$ResourceGroupName = "olu-test-template-rg"
$TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-gateway-v2.json"

Describe "App Gateway Deployment Tests" -Tag "Acceptance" {
  
  Context "When an app gateway is deployed with just a single pool" {
    $TemplateParameters = @{
      appGatewayName      = "dfc-foo-bar-ag"
      subnetRef           = "/subscriptions/d28ae51b-c7ef-41b3-8ee0-644dac2b5152/resourceGroups/dfc-foo-bar-rg/providers/Microsoft.Network/virtualNetworks/dfc-foo-bar-vnet/subnets/appgateway"
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
      userAssignedIdentityName = "olu-test-template-uim"
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