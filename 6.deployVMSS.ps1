$setup = Get-Content .\setup.json | ConvertFrom-Json

$parameters = @{
    vmssName       = ($setup.vmssName)
    imageReference = (Get-AzGalleryImageVersion -ResourceGroupName $setup.galleryResourceGroupName -GalleryImageDefinitionName $setup.galleryImageDefinitionName -GalleryName $setup.galleryName | Sort-Object -Descending -Property Name | Select-Object -First 1).Id
    sshKey         = (Get-Content ~/.ssh/id_rsa.pub).ToString()
}

New-AzResourceGroupDeployment `
    -ResourceGroupName $setup.vmssResourceGroupName `
    -TemplateFile .\vmss.json `
    -TemplateParameterObject $parameters `
    -Name vmss-extension

#Get latest version
#Get-AzGalleryImageVersion -ResourceGroupName imagebuilder -GalleryImageDefinitionName rjfmUbuntu1804 -GalleryName sigvmmsexttest | Sort-Object -Descending -Property {$_.PublishingProfile.PublishedDate} | Select-Object -First 1

#Get all versions
#Get-AzGalleryImageVersion -ResourceGroupName imagebuilder -GalleryImageDefinitionName rjfmUbuntu1804 -GalleryName sigvmmsexttest | Format-Table -Property Name, @{Label="Published"; Expression={$_.PublishingProfile.PublishedDate}}, Id

#Update-AzGalleryImageVersion -ResourceGroupName imagebuilder -GalleryImageDefinitionName rjfmUbuntu1804 -GalleryName sigvmmsexttest -PublishingProfileExcludeFromLatest -Name 0.24378.26966

#Get-AzGalleryImageVersion -ResourceGroupName imagebuilder -GalleryImageDefinitionName rjfmUbuntu1804 -GalleryName sigvmmsexttest | Where-Object { $_.PublishingProfile.ExcludeFromLatest -eq $False }
