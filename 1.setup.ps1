$setup = Get-Content .\setup.json | ConvertFrom-Json

New-AzResourceGroup `
    -ResourceGroupName $setup.galleryResourceGroupName `
    -Location $setup.location

New-AzResourceGroup `
    -ResourceGroupName $setup.vmssResourceGroupName `
    -Location $setup.location

if ((Get-AzProviderFeature -FeatureName VirtualMachineTemplatePreview -ProviderNamespace Microsoft.VirtualMachineImages).RegistrationState -ne "Registered") {
    Register-AzProviderFeature -FeatureName VirtualMachineTemplatePreview -ProviderNamespace Microsoft.VirtualMachineImages
}

if ((Get-AzProviderFeature -FeatureName GalleryPreview -ProviderNamespace Microsoft.Compute).RegistrationState -ne "Registered") {
    Register-AzProviderFeature -FeatureName GalleryPreview -ProviderNamespace Microsoft.Compute
}

# if ((Get-AzProviderFeature -FeatureName GalleryRemoveUserSourceDependency -ProviderNamespace Microsoft.Compute).RegistrationState -ne "Registered") {
#     Register-AzProviderFeature -FeatureName GalleryRemoveUserSourceDependency -ProviderNamespace Microsoft.Compute
# }

while ((Get-AzProviderFeature -FeatureName GalleryRemoveUserSourceDependency -ProviderNamespace Microsoft.Compute).RegistrationState -ne "Registered") {
    Start-Sleep -Seconds 10
}

while ((Get-AzProviderFeature -FeatureName VirtualMachineTemplatePreview -ProviderNamespace Microsoft.VirtualMachineImages).RegistrationState -ne "Registered") {
    Start-Sleep -Seconds 10
}

# while ((Get-AzProviderFeature -FeatureName GalleryPreview -ProviderNamespace Microsoft.Compute).RegistrationState -ne "Registered") {
#     Start-Sleep -Seconds 10
# }