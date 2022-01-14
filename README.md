# Intune-Sync

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
