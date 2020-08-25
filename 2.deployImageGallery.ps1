$setup = Get-Content .\setup.json | ConvertFrom-Json

$parameters = @{
    galleryName                = ($setup.galleryName)
    galleryImageDefinitionName = ($setup.galleryImageDefinitionName)
}

New-AzResourceGroupDeployment `
    -ResourceGroupName $setup.galleryResourceGroupName `
    -TemplateFile .\gallery.json `
    -TemplateParameterObject $parameters `
    -Name sig-imagebuilder