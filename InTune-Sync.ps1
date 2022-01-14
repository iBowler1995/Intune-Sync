
<#
    NOTES
	===========================================================================
	 Script Name: Intune-Sync
	 Created on:   	11/25/2021
	 Created by:   	iBowler1995
	 Filename: Intune-Sync.ps1
	===========================================================================
	.DESCRIPTION
		This script is used to invoke a device sync with Intune.
	===========================================================================
	IMPORTANT:
	===========================================================================
	This script is provided 'as is' without any warranty. Any issues stemming 
	from use is on the user.

    Account must have Graph permissions granted. If not yet done, MS login window
    should walk you through the process.
    ===========================================================================
    .PARAMETER ALL
    This paremeter specifies to invoke a device sync for all Intune devices.
    .PARAMETER TARGET
    This paremeter specifies a single target to invoke a sync on.
    ===========================================================================
    .EXAMPLES

    Intune-Sync.ps1 -All <--- This will invoke a device sync for all Intune devices

    Intune-Sync.ps1 -Target DESKTOP-HJL3ZK <--- This will invoke a device sync for just DESKTOP-HJL3ZK
   #>

[cmdletbinding()]
param (
    [Parameter(Mandatory = $False)]
    [Switch]$All,
    [Parameter(Mandatory = $False)]
    [String]$Target
)

#Quick check to make sure the proper module is installed
$IntuneModule = Get-Module -Name "Microsoft.Graph.Intune" -ListAvailable

if (!$IntuneModule){

#This is required to install the Graph module - not all devices have it or the appropriate version, so we make sure the script host does
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -AllowClobber
Install-Module -Name "Microsoft.Graph.Intune"  

}

#Quick check to ensure we're connected to Microsoft Graph
 if(!(Connect-MSGraph)){

Connect-MSGraph

}

If ($All){

    #Gathers all Intune Windows devices
    $Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem,'Windows')" 
    Foreach ($Device in $Devices)
    {
        Try {
            #Invoking a sync for each device
            Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
            Write-Host "Sending Sync request to Device $($Device.deviceName)" -ForegroundColor Yellow
        }
        catch {
            "Invoke failed for device $Device. Error reason: $($Error)"
        }
        
 
    }
    
}
elseif ($Target){

    Try {
        #This searches for the target device
        $Device = Get-IntuneManagedDevice -Filter "deviceName eq '$Target'"
        #This invokes a sync for the target device
        Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
        Write-Host "Sending Sync request to device $Target" -ForegroundColor Yellow
    }
    catch {
        "Invoke failed for device $Device. Error reason: $($Error)"
    }

}
elseif (!$Target -and !$All){

    Write-Host "All switch not used and no target provided. Please run script again either using -All or -Target followed by the device's name."

}
