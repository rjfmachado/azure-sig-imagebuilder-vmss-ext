$setup = Get-Content .\setup.json | ConvertFrom-Json

$imageBuildStatus = Invoke-AzRestMethod `
    -ResourceGroupName $setup.galleryResourceGroupName `
    -ResourceProviderName Microsoft.VirtualMachineImages `
    -ResourceType imageTemplates `
    -Name $setup.galleryImageDefinitionName `
    -ApiVersion 2020-02-14 `
    -Method GET

($imageBuildStatus.Content | ConvertFrom-Json).properties.lastRunStatus