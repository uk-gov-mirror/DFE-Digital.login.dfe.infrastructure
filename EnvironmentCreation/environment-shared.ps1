param(
    [Parameter(Mandatory=$true)]
    [string]$environmentShortName
)

$appServicePlanSku = @{
    name = "S2"
    tier = "Standard"
    size = "S2"
    family = "S"
    capacity = 1
}

$postgresSku = @{
    name = "B_Gen5_1"
    tier = "Basic"
    skuSizeMB = 5120
    family = "Gen5"
    capacity = 1
}

$azureSearchSku = "standard"

$redisCacheSku = @{
    name = "Standard"
    family = "C"
    capacity = 1
}

$sqlAdministratorLogin = "leonardo-eddie-morrison"

$accessPolicyObjectId = "b6280477-d815-4533-8992-f114dedf9063"

# Running Variables

$resourceGroupPrefix = "rg-$($environmentShortName)-signin"

$resourceGroupName = "$($resourceGroupPrefix)-shd"

Remove-AzureRmResourceGroup -ResourceGroupName $resourceGroupName -Force

# Create the resource group
New-AzureRmResourceGroup -ResourceGroupName $resourceGroupName -Location "West Europe"

# Create the key vault
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/key-vault.json -keyVaultName "$($environmentShortName)-signin-shd-kv" -AccessPolicyObjectId $accessPolicyObjectId

# Wait for entries into the keyvault
Write-Host -NoNewLine 'Please set up the key vault permissions and values, then press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# Create the ASP
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/app-service-plan.json -appServicePlanName "$($environmentShortName)-signin-shd-asp" -appServicePlanSku $appServicePlanSku -appServicePlanOS "Windows" -appServicePlanIsLinux $false

# Create the Azure Search Service
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/azure-search.json -azureSearchName "$($environmentShortName)-signin-shd-azs" -azureSearchSku $azureSearchSku 

# Create the App Insights
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/app-insights.json -appInsightsName "$($environmentShortName)-signin-shd-ai"

# Create the storage account
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/storage-account.json -storageAccountName "$($environmentShortName)signinshdstr"

# Create the Postgres Server
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/postgres-deploy.json -postgresAdministratorLogin "pgadmin" -postgresAdminSecretName "$($environmentShortName)-pg-adminpass" -keyVaultName "$($environmentShortName)-signin-shd-kv" -sharedResourceGroup $resourceGroupName -postgresServerName "$($environmentShortName)-signin-shd-pg"

# Create the Sql Server
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/azure-sql-deploy.json -sqlServerName "$($environmentShortName)-signin-shd-sql" -elasticPoolName "$($environmentShortName)-signin-shd-ep" -sqlAdministratorLogin $sqlAdministratorLogin -sqlAdminSecretName "$($environmentShortName)-pg-adminpass" -sharedResourceGroup $resourceGroupName -keyVaultName "$($environmentShortName)-signin-shd-kv" -EPGWIP "194.72.47.162" -CHGWIP "217.33.132.234"

# Create the audit database
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/database.json -databaseName "$($environmentShortName)-signin-audit-db" -elasticPoolName "$($environmentShortName)-signin-shd-ep" -sqlServerName "$($environmentShortName)-signin-shd-sql"

# Create the directories database
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/database.json -databaseName "$($environmentShortName)-signin-directories-db" -elasticPoolName "$($environmentShortName)-signin-shd-ep" -sqlServerName "$($environmentShortName)-signin-shd-sql"

# Create the organisations database
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/database.json -databaseName "$($environmentShortName)-signin-organisations-db" -elasticPoolName "$($environmentShortName)-signin-shd-ep" -sqlServerName "$($environmentShortName)-signin-shd-sql"

# Create the KTS database
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/database.json -databaseName "KTSNOV2017" -elasticPoolName "$($environmentShortName)-signin-shd-ep" -sqlServerName "$($environmentShortName)-signin-shd-sql"

# Create the Redis Cache
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ../Shared/redis-cache.json -redisCacheName "$($environmentShortName)-signin-shd-rc" -redisCacheSku $redisCacheSku 