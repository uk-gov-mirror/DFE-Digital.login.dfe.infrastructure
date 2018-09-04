param(
    [Parameter(Mandatory=$true)]
    [string]$environmentShortName
)

$appServicePlanSku = @{
    name = "S1"
    tier = "Standard"
    size = "S1"
    family = "S"
    capacity = 1
}

$resourceGroupPrefix = "rg-$($environmentShortName)-signin"
$colour = "red"

$resourceGroupName = "$($resourceGroupPrefix)-$($colour)"

# Remove the resource group
Remove-AzureRmResourceGroup -ResourceGroupName $resourceGroupName -Force

# Create the resource group
New-AzureRmResourceGroup -ResourceGroupName $resourceGroupName -Location "West Europe"

# Create the ASP
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/app-service-plan.json -appServicePlanName "$($environmentShortName)-signin-$($colour)-asp" -appServicePlanSku $appServicePlanSku -appServicePlanOS "Windows" -appServicePlanIsLinux $false