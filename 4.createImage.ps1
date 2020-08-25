$setup = Get-Content .\setup.json | ConvertFrom-Json

Invoke-AzResourceAction `
    -ResourceGroupName $setup.galleryResourceGroupName `
    -ResourceType Microsoft.VirtualMachineImages/imageTemplates `
    -ResourceName $setup.galleryImageDefinitionName `
    -Action Run
