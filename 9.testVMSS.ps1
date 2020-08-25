$setup = Get-Content .\setup.json | ConvertFrom-Json
$fqdn = (Get-AzPublicIpAddress -ResourceGroupName $setup.vmssResourceGroupName -Name ([string]::concat($setup.vmssName, "pip"))).DnsSettings.Fqdn

do {
    $result = (Invoke-WebRequest -Uri $fqdn).content
    $result
    Start-Sleep -Seconds 5
} while ($true)
