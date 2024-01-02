\\This file in b1 branch is modified
New-AzResourceGroup `
   -Name ResGrp `
   -Location EastUS

New-AzAvailabilitySet `
   -Location "EastUS" `
   -Name "AvblSet" `
   -ResourceGroupName "ResGrp" `
   -Sku aligned `   # Use 'Aligned' for virtual machines with managed disks and 'Classic' for virtual machines with unmanaged disks. Default value is 'Classic'.
   -PlatformFaultDomainCount 2 `
   -PlatformUpdateDomainCount 2
$cred = Get-Credential

for ($i=1; $i -le 3; $i++)
{
    New-AzVm `
        -ResourceGroupName "ResGrp" `
        -Name "VM$i" `
        -Location "East US" `
        -VirtualNetworkName "Vnet" `
        -SubnetName "Sub" `
        -SecurityGroupName "myNetworkSecurityGroup" `
        -PublicIpAddressName "Pbip$i" `
        -AvailabilitySetName "mAvblSet" `
        -Credential $cred
}

Get-AzVMSize `
   -ResourceGroupName "ResGrp" `
   -AvailabilitySetName "AvblySet"
