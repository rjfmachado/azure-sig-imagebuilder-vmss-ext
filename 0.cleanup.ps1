$parameters = Get-Content .\setup.json | ConvertFrom-Json

Remove-AzResourceGroup -ResourceGroupName $parameters.galleryResourceGroupName -Force
Remove-AzResourceGroup -ResourceGroupName $parameters.vmssResourceGroupName -Force