
Param(  
    [string]$chocolateyAppList = "vlc,brave,google-drive-file-stream,lavfilters7zip,wsl2,steam,obsidian,packer,vault,obs-studio,zoom,signal,github,terraform,vagrant,discord,telegram,slack,vscode,awscli,spotify,vcredist140,vcredist2013,vcredist2008,vcredist2012,vcredist2010",
    [string]$desktop = $false,
    [string]$nvidia = $true
    # [string]$dismAppList = "Microsoft-Windows-Subsystem-Linux, VirtualMachinePlatform"
)

if ([string]::IsNullOrWhiteSpace($chocolateyAppList) -eq $false -or [string]::IsNullOrWhiteSpace($dismAppList) -eq $false)
{
    try{
        choco config get cacheLocation
    }catch{
        Write-Output "Chocolatey not detected, trying to install now"
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

if ([string]($desktop) -eq $true){   
    Write-Host "Desktop has been specified"
    $desktopapps = "amd-ryzen-chipset, streamdeck, nvidia-display-driver"
    $appsToInstall = $desktopapps -split "," | ForEach-Object { "$($_.Trim())" }

    foreach ($app in $appsToInstall)
    {
        Write-Host "Installing $app"
        & choco install $app /y | Write-Output
    }
}

if ([string]($nvidia) -eq $true){   
    Write-Host "Nvidia Option Specified, Installing Drivers"  
    choco feature enable -n=useRememberedArgumentsForUpgrades
    choco install nvidia-display-driver --package-parameters="'/dch'" /y | Write-Output
    
}



if ([string]::IsNullOrWhiteSpace($chocolateyAppList) -eq $false){   
    Write-Host "Chocolatey Apps Specified"  f
    
    $appsToInstall = $chocolateyAppList -split "," | ForEach-Object { "$($_.Trim())" }

    foreach ($app in $appsToInstall)
    {
        Write-Host "Installing $app"
        & choco install $app /y | Write-Output
    }
}
