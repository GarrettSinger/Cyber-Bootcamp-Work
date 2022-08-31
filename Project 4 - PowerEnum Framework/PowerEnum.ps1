Function Run-BootCampFinalProject{
<#  
.SYNOPSIS
Powershell Enumeration/Pentesting Framework

.DESCRIPTION
This program is meant to assist the System Administrator with examining devices on their network. This is not for illicit uses.
This is also a showcase of techniques in powershell scripting. This is not a final product meant to achieve any specific goal, job, or whatever plan you may have for it.
Not covered by any warranty! User Beware!
Free use is allowed. Please leave my name credited within the program even if it is not writen to output.

.PARAMETER ErrorLog
Specify a path to a file to log errors. The default is C:\Errors.txt

.PARAMETER OutputPath
Specify a path to where files wioll be stored when using this framework. The default is $env:USERPROFILE\appdata\local\Enum

.EXAMPLE
PS C:\> Run-BootCampFinalProject

Starts the Framework.

.EXAMPLE
PS C:\> Run-BootCampFinalProject -Errorlog c:\logs\errors.txt

This expression will write all errors to the designated log file. There is no logging by default.

.EXAMPLE
PS C:\> Run-BootCampFinalProject -OutputPath c:\windows\temp\EnumFiles

This expression will write all files to the designated folder path.
#>

	[cmdletbinding()]
	param(
	[Parameter(Mandatory=$False,position=0,ValueFromPipeline=$True)]
	[Validatenotnullorempty()]
	[string]$ErrorLog = 'c:\windows\temp\Error.txt',
	[Switch]$LogErrors,
	[Parameter(Mandatory=$False,position=1,ValueFromPipeline=$True)]
	[ValidateNotNullOrEmpty()]
	[String]$OutputPath,
	[Parameter(Mandatory=$False,position=3,ValueFromPipeline=$True)]
	[Validatenotnullorempty()]
	[switch]$Help,
	[Parameter(Mandatory=$False,position=5,ValueFromPipeline=$True)]
	[Validatenotnullorempty()]
	[switch]$full
	)

	<# Start Begin Section #>
	Begin{
   	 
    	<# Start with a clean interface #>
    	Clear
    	<# Check if help was asked for #>
    	if($help -eq $true -and $full -eq $false){
        	get-help Run-BootCampFinalProject; Break
    	}elseif($help -eq $true -and $full -eq $true){
        	get-help Run-BootCampFinalProject -full; Break
    	}

    	<# START Setup Environmet: #>
    
        	<# START Form Drawing:#>
        	Add-Type -AssemblyName System.Windows.Forms
        	$SaveFileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop')}
        	$SelectFileBrowserCSV = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop')}
        	<# END Form Drawing:#>
       	 
        	<# Create Folder Directory #>

        	Function CreateOutputFolder{
            	param ($SelectedOutputPath)
            	<# Verbose mode #>
            	If(($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) -eq $true){
                	<# Check if output selected #>
                	if(![string]::IsNullOrEmpty($OutputPath)){
   	             	<# See if file exists #>
                    	$OutputPathExists = test-path $OutputPath -Verbose
                    	If($OutputPathExists -eq $true){
                        	write-verbose "OutputPath $OutputPath Exists! No new folder created."
                        	$SelectedOutputPath = $OutputPath
                    	}else{
                        	<# If not, make #>
                        	New-item -ItemType Directory $OutputPath -Verbose |Out-Null
                        	Write-Verbose "OutputPath $OutputPath created."
                        	$SelectedOutputPath = $OutputPath
                    	}
   		 
                	}Else{
                	<# Check if output default #>
                    	write-verbose "No Output Path Specified. Setting default to $env:USERPROFILE\appdata\local\Enum"
   	             	<# see if file exists #>
                        	If($(test-path $env:USERPROFILE\appdata\local\Enum) -eq $true){
                            	$DefaultOutputPath = "$env:USERPROFILE\appdata\local\Enum"
                            	write-verbose "Folder exists at $DefaultOutputPath"
                            	write-verbose "Use -OutputPath in the future to designate a different output location"
                            	$SelectedOutputPath = $DefaultOutputPath
                        	}
                        	elseif($(test-path $env:USERPROFILE\appdata\local\Enum) -ne $true){
                            	<# if not, make #>
                            	$DefaultOutputPath = "$env:USERPROFILE\appdata\local\Enum"
                            	New-Item -ItemType Directory $DefaultOutputPath -Verbose |Out-Null
                            	write-verbose "Folder created at $DefaultOutputPath"
                            	write-verbose "Use -OutputPath in the future to designate a different output location"
                            	$SelectedOutputPath = $DefaultOutputPath
                        	}  	 
                	}
            	Pause
            	}Else{
                	<# Check if output selected #>
                	if(![string]::IsNullOrEmpty($OutputPath)){
   	             	<# See if file exists #>
                    	$OutputPathExists = test-path $OutputPat
                    	If($OutputPathExists -eq $true){
                        	$SelectedOutputPath = $OutputPath
                    	}else{
                        	<# If not, make #>
                        	New-item -ItemType Directory $OutputPath |Out-Null
                        	$SelectedOutputPath = $OutputPath
                    	}
   		 
                	}Else{
                	<# Check if output default #>
                    	write-verbose "No Output Path Specified. Setting default to $env:USERPROFILE\appdata\local\Enum"
   	             	<# see if file exists #>
                        	If($(test-path $env:USERPROFILE\appdata\local\Enum) -eq $true){
                            	$DefaultOutputPath = "$env:USERPROFILE\appdata\local\Enum"
                            	$SelectedOutputPath = $DefaultOutputPath
                        	}
                        	elseif($(test-path $env:USERPROFILE\appdata\local\Enum) -ne $true){
                            	<# if not, make #>
                            	$DefaultOutputPath = "$env:USERPROFILE\appdata\local\Enum"
                            	New-Item -ItemType Directory $DefaultOutputPath |Out-Null
                            	$SelectedOutputPath = $DefaultOutputPath
                        	}  	 
                	}
            	} Return $SelectedOutputPath
        	}

        	$SelectedOutputPath = CreateOutputFolder
            move-item .\Run-BootCampFinalProject.ps1 $SelectedOutputPath -Force
            set-location $SelectedOutputPath
            new-item -ItemType Directory Modules
            
            <# Check Privilege Context#>
            $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
            $RunningAsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

            <# Adujst Buffer Size #>
            if( $Host -and $Host.UI -and $Host.UI.RawUI ) {
              $rawUI = $Host.UI.RawUI
              $oldSize = $rawUI.BufferSize
              $typeName = $oldSize.GetType( ).FullName
              $newSize = New-Object $typeName (300, $oldSize.Height)
              $rawUI.BufferSize = $newSize
            }

            <# Start Main Function Delerations #>
        
            <# ASCII Art Program and Author Name #>
    	    Function CoolASCIIArt{
       	    "||/======================================================================================================================================================================================================================================================================\||"
        	"||/_______________________________________/\\\\\\\\\\\\\______________________________________________________________________/\\\\\\\\\\\\\\\___________________________________________________________________________________________________________________________\||"                                                                  	 
        	"||/_______________________________________\/\\\/////////\\\___________________________________________________________________\/\\\///////////___________________________________________________________________________________________________________________________\||"                                                                 	 
        	"||/________________________________________\/\\\_______\/\\\___________________________________________________________________\/\\\_____________________________________________________________________________________________________________________________________\||"                                                                	 
        	"||/_________________________________________\/\\\\\\\\\\\\\/_______/\\\\\______/\\____/\\___/\\______/\\\\\\\\____/\\/\\\\\\\___\/\\\\\\\\\\\_______/\\/\\\\\\_____/\\\____/\\\_____/\\\\\__/\\\\\_______________________________________________________________________\||"                                                               	 
        	"||/__________________________________________\/\\\/////////_______/\\\///\\\___\/\\\__/\\\\_/\\\____/\\\_____\\\__\/\\\/////\\\__\/\\\///////_______\/\\\////\\\___\/\\\___\/\\\___/\\\///\\\\\///\\\____________________________________________________________________\||"                                                              	 
        	"||/___________________________________________\/\\\_______________/\\\__\//\\\__\//\\\/\\\\\/\\\____/\\\\\\\\\\\___\/\\\___\///___\/\\\______________\/\\\__\//\\\__\/\\\___\/\\\__\/\\\_\//\\\__\/\\\___________________________________________________________________\||"                                                             	 
        	"||/____________________________________________\/\\\______________\//\\\__/\\\____\//\\\\\/\\\\\____\//\\///////____\/\\\__________\/\\\______________\/\\\___\/\\\__\/\\\___\/\\\__\/\\\__\/\\\__\/\\\__________________________________________________________________\||"                                                            	 
        	"||/_____________________________________________\/\\\_______________\///\\\\\/______\//\\\\//\\\______\//\\\\\\\\\\__\/\\\__________\/\\\\\\\\\\\\\\\__\/\\\___\/\\\__\//\\\\\\\\\___\/\\\__\/\\\__\/\\\_________________________________________________________________\||"                                                           	 
        	"||/______________________________________________\///__________________\/////_________\///__\///________\//////////___\///___________\///////////////___\///____\///____\/////////____\///___\///___\///_________________________________________________________________\||"                                                          	 
        	"||/_/\\\\\\\\\\\\\___________________________________/\\\\\\\\\\\\_____________________________________________________________________________________________________________/\\\\\\\\\\\______________________________________________________________________________\||"
        	"||/_\/\\\/////////\\\_______________________________/\\\//////////____________________________________________________________________________________________________________/\\\/////////\\\___________________________________________________________________________\||"  	 
        	"||/__\/\\\_______\/\\\_____/\\\__/\\\_______________/\\\________________________________________________________________________________/\\\___________/\\\___________________\//\\\______\///____/\\\___________________/\\\\\\\\_______________________________________\||" 	 
        	"||/___\/\\\\\\\\\\\\\\_____\//\\\/\\\_______________\/\\\____/\\\\\\\___/\\\\\\\\\______/\\/\\\\\\\____/\\/\\\\\\\_______/\\\\\\\\____/\\\\\\\\\\\___/\\\\\\\\\\\_______________\////\\\__________\///____/\\/\\\\\\_____/\\\____\\\______/\\\\\\\\____/\\/\\\\\\\_______\||"	 
        	"||/____\/\\\/////////\\\_____\//\\\\\_____/\\\_______\/\\\___\/////\\\__\////////\\\____\/\\\/////\\\__\/\\\/////\\\____/\\\_____\\\__\////\\\////___\////\\\////___________________\////\\\________/\\\__\/\\\////\\\___\//\\\\\\\\\____/\\\____ \\\__\/\\\/////\\\_____\||"    
        	"||/_____\/\\\_______\/\\\______\//\\\_____\///________\/\\\_______\/\\\____/\\\\\\\\\\___\/\\\___\///___\/\\\___\///____/\\\\\\\\\\\______\/\\\__________\/\\\__________________________\////\\\____\/\\\__\/\\\__\//\\\___\///////\\\___/\\\\\\\\\\\___\/\\\___\///_____\||"   
        	"||/______\/\\\_______\/\\\___/\\_/\\\__________________\/\\\_______\/\\\___/\\\_____\\\___\/\\\__________\/\\\__________\//\\______________\/\\\_/\\______\/\\\_/\\_______________/\\\______\//\\\___\/\\\__\/\\\___\/\\\___/\\_____\\\__\//\\___________\/\\\___________\||"  
        	"||/_______\/\\\\\\\\\\\\\/___\//\\\\/________/\\\_______\//\\\\\\\\\\\\/___\//\\\\\\\\/\\__\/\\\__________\/\\\___________\//\\\\\\\\\\_____\//\\\\\_______\//\\\\\_______________\///\\\\\\\\\\\/____\/\\\__\/\\\___\/\\\__\//\\\\\\\\____\//\\\\\\\\\\__\/\\\__________\||"
        	"||/________\/////////////______\////_________\///_________\////////////______\////////\//___\///___________\///_____________\//////////_______\/////_________\/////__________________\///////////______\///___\///____\///____\////////______\//////////___\///__________\||"
            "||/======================================================================================================================================================================================================================================================================\||"
            "`n"
    	}

    	    <# This dynamic menu lists the options available at the program root! Users can pick tool sections from this menu. #>
    	    Function MainMenu($MainMenuOptions){
        	<# This clear ensures we are working with a clean display #>
        	Clear

        	<# Call Cool ASCII Art Intro #>
        	CoolASCIIArt
            $Count = 1
            $MainMenu = @(
                	"Main Menu: Please select an option.
                	`n"
        	)
            foreach($item in $MainMenuOptions){
            	If($Count -lt "10"){
                	If(![string]::IsNullOrEmpty($($MainMenuOptions[$count-1]))){
                    	$MainMenu += "0$count) $($MainMenuOptions[$count-1])"
                	}
            	}else{
                	If(![string]::IsNullOrEmpty($($MainMenuOptions[$count-1]))){
                    	$MainMenu += "$count) $($MainMenuOptions[$count-1])"
                	}
            	}
            	$count++
        	}
        	$MainMenu += "`n"
        	$MainMenu
    	}

    	    #This Dynamic menu lists the tool selections available at the tools level. Users can pick tools from this menu.
    	    Function ToolSelectionMenu($OptionsInput){
        	$Count = 1
        	$ToolSelectionMenu = @(
                	"Menu: Please select an option.
                	`n"
        	)
        	foreach($item in $OptionsInput){
            	If($Count -lt "10"){
                	If(![string]::IsNullOrEmpty($($OptionsInput[$count-1]))){
                    	$ToolSelectionMenu += "0$count) $($OptionsInput[$count-1])"
                	}
            	}else{
                	If(![string]::IsNullOrEmpty($($OptionsInput[$count-1]))){
                    	$ToolSelectionMenu += "$count) $($OptionsInput[$count-1])"
                	}
            	}
            	$count++
        	}
        	$ToolSelectionMenu += "`n"
        	$ToolSelectionMenu
    	}
            
            <# The following Functions are named for what they accomplish #>
        	Function Clear-Caches{
   	 
        	<# Write Verbose & Output Information to the screen #>
        	Write-Verbose "Getting User Information"
        	Write-Verbose "User is $env:username"
        	Write-Output "Clearing Caches for $env:username"

        	<# Progress parameter #>
        	$Progress = @{
            	Activity = 'Removing FireFox Cache items:'
            	CurrentOperation = "Erasing Files"
            	Status = 'Removing data'
            	PercentComplete = 0
        	}

        	Write-Progress @Progress
        	$i = 0

        	if($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent)){
            	$FireFoxCommands = @(
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\* -Recurse -Force -EA SilentlyContinue -Verbose}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\*.* -Recurse -Force -EA SilentlyContinue -Verbose}
   		     	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache2\entries\*.* -Recurse -Force -EA SilentlyContinue -Verbose}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\thumbnails\* -Recurse -Force -EA SilentlyContinue -Verbose}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cookies.sqlite -Recurse -Force -EA SilentlyContinue -Verbose}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\webappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\chromeappsstore.sqlite -Recurse -Force -EA SilentlyContinue -Verbose}
            	)
        	}elseif($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) -eq $Null){
            	$FireFoxCommands = @(
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\* -Recurse -Force -EA SilentlyContinue}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache\*.* -Recurse -Force -EA SilentlyContinue}
   		     	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache2\entries\*.* -Recurse -Force -EA SilentlyContinue}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\thumbnails\* -Recurse -Force -EA SilentlyContinue}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\cookies.sqlite -Recurse -Force -EA SilentlyContinue}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\webappsstore.sqlite -Recurse -Force -EA SilentlyContinue}
                	{Remove-Item -path $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\*.default\chromeappsstore.sqlite -Recurse -Force -EA SilentlyContinue}
            	)
        	}

        	foreach($Command in $FireFoxCommands){
            	$i++
            	[int]$Percentage = ($i / $FireFoxCommands.count)*100
            	$Name = "$($FireFoxCommands[$i-1])"
            	$Progress.CurrentOperation = "$Name"
            	$Progress.Status = "$Name"
            	$Progress.PercentComplete = $Percentage
            	Write-Progress @Progress
            	$Job = "$($FireFoxCommands[$i-1])"
            	start-job {$Job} | Out-Null
            	Wait-Job (get-job | select -first 1) | out-null
            	Get-Job|Remove-Job
        	}

        	<# Progress parameter #>
        	$Progress = @{
            	Activity = 'Removing Chrome Cache items:'
            	CurrentOperation = "Erasing Files"
            	Status = 'Removing data'
            	PercentComplete = 0
        	}

        	Write-Progress @Progress
        	$i = 0

        	if($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent)){
            	$ChromeCommands = @(
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\cache\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose}
   		 	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue -Verbose}
   		 	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\History" -Recurse -Force -EA SilentlyContinue -Verbose}
            	)
        	}elseif($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) -eq $Null){
            	$ChromeCommands = @(
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\cache\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue}
   		 	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue}
   		 	{Remove-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\History" -Recurse -Force -EA SilentlyContinue}
            	)
        	}

        	foreach($Command in $ChromeCommands){
            	$i++
            	[int]$Percentage = ($i / $ChromeCommands.count)*100
            	$Name = "$($ChromeCommands[$i-1])"
            	$Progress.CurrentOperation = "$Name"
            	$Progress.Status = "$Name"
            	$Progress.PercentComplete = $Percentage
            	Write-Progress @Progress
            	$Job = "$($ChromeCommands[$i-1])"
            	start-job {$Job} | Out-Null
            	Wait-Job (get-job | select -first 1) | out-null
            	Get-Job|Remove-Job
        	}

        	<# Progress parameter #>
        	$Progress = @{
            	Activity = 'Removing Internet Explorer Cache items:'
            	CurrentOperation = "Erasing Files"
            	Status = 'Removing data'
            	PercentComplete = 0
        	}

        	Write-Progress @Progress
        	$i = 0

        	if($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent)){
            	$IECommands = @(
            	{Remove-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "C:\Windows\Temp\*" -Recurse -Force -EA SilentlyContinue -Verbose}
            	{Remove-Item -path "C:\`$recycle.bin\" -Recurse -Force -EA SilentlyContinue -Verbose}
            	)
        	}elseif($($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) -eq $Null){
            	$IECommands = @(
            	{Remove-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "$env:userprofile\AppData\Local\Temp\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "C:\Windows\Temp\*" -Recurse -Force -EA SilentlyContinue}
            	{Remove-Item -path "C:\`$recycle.bin\" -Recurse -Force -EA SilentlyContinue}
            	)
        	}

        	foreach($Command in $IECommands){
            	$i++
            	[int]$Percentage = ($i / $IECommands.count)*100
            	$Name = "$($IECommands[$i-1])"
            	$Progress.CurrentOperation = "$Name"
            	$Progress.Status = "$Name"
            	$Progress.PercentComplete = $Percentage
            	Write-Progress @Progress
            	$Job = "$($IECommands[$i-1])"
            	start-job {$Job} | Out-Null
            	Wait-Job (get-job | select -first 1) | out-null
            	Get-Job|Remove-Job
        	}
        	Write-Progress -Activity "Removing Internet Explorer Cache items:" -Status "Ready" -Completed
        	clear
    	}

            Function Copy-Caches{
        	$ErrorActionPreference = "SilentlyContinue"
        	<# Write Verbose & Output Information to the screen #>
        	Write-Verbose "Getting User Information"
        	Write-Verbose "User is $env:username"
        	Write-Output "Copying Caches for $env:username. Please wait."

        	$Destination = "$SelectedOutputPath\FireFox"
        	if((test-path $Destination) -eq $false){new-item $Destination -ItemType Directory -Force}
            	<# FireFox Commands #>
            	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "cache"}).FullName) -Recurse -Destination $Destination\ -Container -Force -EA SilentlyContinue -Verbose
   		 	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "cache2"} | gci | ?{$_.name -like "entries"}).FullName) -Recurse -Destination $Destination\cache2\entries\ -Container -Force -EA SilentlyContinue -Verbose
            	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "thumbnails"}).FullName) -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "cookies.sqlite"}).FullName) -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "webappsstore.sqlite"}).FullName) -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	Copy-Item -path ((gci $env:userprofile\AppData\Local\Mozilla\Firefox\Profiles\ | ?{$_.name -like "*.default"} | gci | ?{$_.name -like "chromeappsstore.sqlite"}).FullName) -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
       	 
        	$Destination = "$SelectedOutputPath\Chrome"
        	if((test-path $Destination) -eq $false){new-item $Destination -ItemType Directory -Force}
            	<# Chrome Commands #>
            	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\cache\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
   		 	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal" -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
   		 	copy-Item -path "$env:userprofile\AppData\Local\Google\Chrome\User Data\Default\History" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose

        	$Destination = "$SelectedOutputPath\IE"
        	if((test-path $Destination) -eq $false){new-item $Destination -ItemType Directory -Force}
            	<# IECommands #>
            	copy-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "$env:userprofile\AppData\Local\Temp\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "C:\Windows\Temp\*" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose
            	copy-Item -path "C:\`$recycle.bin\" -Recurse -Destination  $Destination\ -Container -Force -EA SilentlyContinue -Verbose

        	clear
        	$ErrorActionPreference = "Continue"
    	}

            Function Get-POSHHistory{
           	Write-Output "Getting Powershell ISE Command History"
           	"`n"
           	$ISE = get-content "$env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\Windows PowerShell ISE Host_history.txt" -ErrorAction SilentlyContinue
           	If(![string]::IsNullOrEmpty($ISE)){
                	Write-Output "Saving Powershell ISE console History to $SelectedOutputPath"; $ISE | Out-File $SelectedOutputPath\POSHISEConsoleHistory.txt
           	}else{write-output "No ISE history found"}
           	"`n"
           	Write-Output "Getting Powershell Console Command History"
           	"`n"
           	$Console = get-content "$env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -ErrorAction SilentlyContinue
            	If(![string]::IsNullOrEmpty($Console)){
                	Write-Output "Saving Powershell console History to $SelectedOutputPath"; $Console | Out-File $SelectedOutputPath\POSHConsoleHistory.txt
           	}else{write-output "No powershell history found"}
           	"`n"
           	Pause
    	}

    	    Function Get-InstalledApps{
   	 
        	$GetArch = (Get-WMIObject win32_operatingSystem).OSArchitecture

        	if ($GetArch -like "*64*") {
           	 
            	$64RegKey = ("HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall")
            	$Applications = Gci Registry::$64RegKey
            	$Apps = @()
            	Foreach($Item in ($Applications|?{($_).getvalue("DisplayName") -ne $null })){

                	$App = [pscustomobject] @{
               	 
                    	"Display Name" = $Item.getvalue("Displayname")
                    	"Version" = $Item.getvalue("DisplayVersion")
                    	"UninstallString" = $Item.getvalue("UninstallString")
                    	"Publisher" = $Item.getvalue("Publisher")
                    	"Install Date" = $Item.getvalue("InstallDate")
                	}
                	$Apps += $App  
            	}
            	$Apps | export-csv $SelectedOutputPath\InstalledX64Apps.csv -NoTypeInformation
            	write-output "Applications csv file saved to $SelectedOutputPath\InstalledX64Apps.csv"
            	pause

        	}else{
           	 
            	$32RegKey = ("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
            	$Applications = Gci Registry::$32RegKey
            	$Apps = @()
            	Foreach($Item in ($Applications|?{($_).getvalue("DisplayName") -ne $null })){

                	$App = [pscustomobject] @{
               	 
                    	"Display Name" = $Item.getvalue("Displayname")
                    	"Version" = $Item.getvalue("DisplayVersion")
                    	"UninstallString" = $Item.getvalue("UninstallString")
                    	"Publisher" = $Item.getvalue("Publisher")
                    	"Install Date" = $Item.getvalue("InstallDate")
                	}
                	$Apps += $App  
            	}
            	$Apps | export-csv $SelectedOutputPath\InstalledX32Apps.csv -NoTypeInformation
            	write-output "Applications csv file saved to $SelectedOutputPath\InstalledX32Apps.csv"
            	pause
        	}
        	####################################
   	 
    	}

    	    Function Get-WiFiProfiles{
        	<# Create custom Network objects #>
        	$NetworksAvailable = Invoke-Command {netsh WLAN show Profile}
        	$NetworksAvailable = $NetworksAvailable | Select-String :
        	$NetworkOutputs = @()
        	#$line=0

        	foreach($item in ($NetworksAvailable |select -skip 1)){
        	#$host.EnterNestedPrompt()
            	$line = $item -split(":")
            	$line[0] = $line[0].trim()
            	$line[1] = $line[1].trim()

            	$NetworkOutput = [pscustomobject] @{

                	"UserProfile" = $line[0]
                	"Name" = $line[1]
            	}

            	$NetworkOutputs += $NetworkOutput
        	}

        	<# Query Network object names #>
        	$NetworkInfo = @()
        	foreach($network in $NetworkOutputs){    
            	$NetworkFull = Netsh WLAN show profile name="$($network.name)" key=clear
            	If($NetworkFull -notlike "*is not found on the system*"){
                	$NetworkFull = $NetworkFull | Select-String : |select -Skip 2
                	$Networktable = [pscustomobject] @{
   	 
                    	"Version" =  ([string]$NetworkFull[0]).Substring([int](([string]$($NetworkFull[0])).indexof(":")+1)).Trim()
                    	"Type" = ([string]$NetworkFull[1]).Substring([int](([string]$($NetworkFull[1])).indexof(":")+1)).Trim()
                    	"Name" =  ([string]$NetworkFull[2]).Substring([int](([string]$($NetworkFull[2])).indexof(":")+1)).Trim()
                    	"Control options"  = ([string]$NetworkFull[3]).Substring([int](([string]$($NetworkFull[3])).indexof(":")+1)).Trim()
                    	"Connection mode" = ([string]$NetworkFull[4]).Substring([int](([string]$($NetworkFull[4])).indexof(":")+1)).Trim()
                    	"Network broadcast" = ([string]$NetworkFull[5]).Substring([int](([string]$($NetworkFull[5])).indexof(":")+1)).Trim()
                    	"AutoSwitch" = ([string]$NetworkFull[6]).Substring([int](([string]$($NetworkFull[6])).indexof(":")+1)).Trim()
                    	"MAC Randomization" = ([string]$NetworkFull[7]).Substring([int](([string]$($NetworkFull[7])).indexof(":")+1)).Trim()
                    	"Number of SSIDs" = ([string]$NetworkFull[8]).Substring([int](([string]$($NetworkFull[8])).indexof(":")+1)).Trim()
                    	"SSID name" = ([string]$NetworkFull[9]).Substring([int](([string]$($NetworkFull[9])).indexof(":")+1)).Trim()
                    	"Network type" = ([string]$NetworkFull[10]).Substring([int](([string]$($NetworkFull[10])).indexof(":")+1)).Trim()
                    	"Radio type" = ([string]$NetworkFull[11]).Substring([int](([string]$($NetworkFull[11])).indexof(":")+1)).Trim()
                    	"Vendor extension" = ([string]$NetworkFull[12]).Substring([int](([string]$($NetworkFull[12])).indexof(":")+1)).Trim()
                    	"Authentication" = ([string]$NetworkFull[13]).Substring([int](([string]$($NetworkFull[13])).indexof(":")+1)).Trim()
                    	"Cipher"  =  ([string]$NetworkFull[14]).Substring([int](([string]$($NetworkFull[14])).indexof(":")+1)).Trim()
                    	"Authentication 2" = ([string]$NetworkFull[15]).Substring([int](([string]$($NetworkFull[15])).indexof(":")+1)).Trim()
                    	"Cipher 2"  =  ([string]$NetworkFull[16]).Substring([int](([string]$($NetworkFull[16])).indexof(":")+1)).Trim()
                    	"Security key" = ([string]$NetworkFull[17]).Substring([int](([string]$($NetworkFull[17])).indexof(":")+1)).Trim()
                    	"Key Content" = ([string]$NetworkFull[18]).Substring([int](([string]$($NetworkFull[18])).indexof(":")+1)).Trim()
                    	"Cost" = ([string]$NetworkFull[19]).Substring([int](([string]$($NetworkFull[19])).indexof(":")+1)).Trim()
                    	"Congested" = ([string]$NetworkFull[20]).Substring([int](([string]$($NetworkFull[20])).indexof(":")+1)).Trim()
                    	"Approaching Data Limit" = ([string]$NetworkFull[21]).Substring([int](([string]$($NetworkFull[21])).indexof(":")+1)).Trim()
                    	"Over Data Limit" = ([string]$NetworkFull[22]).Substring([int](([string]$($NetworkFull[22])).indexof(":")+1)).Trim()
                    	"Roaming" = ([string]$NetworkFull[23]).Substring([int](([string]$($NetworkFull[23])).indexof(":")+1)).Trim()
                    	"Cost Source" = ([string]$NetworkFull[24]).Substring([int](([string]$($NetworkFull[24])).indexof(":")+1)).Trim()
                	}
                	$NetworkInfo += $Networktable
            	}
        	}

        	$NetworkInfo | export-csv $SelectedOutputPath\WiFiProfiles.csv -NoTypeInformation
    	}

    	    Function Get-LogonHistory{
            if($RunningAsAdmin -eq $true){
        	    $Days = Read-Host "How many days would you like to look back?"
        	    $ReviewDate = (get-date).AddDays(-$Days)
        	    $Logonevents = Get-Eventlog -LogName Security -ComputerName $env:computername -After $ReviewDate | where {$_.eventID -eq 4624 }
        	    $Formatted = @()
        	    foreach($Record in $logonevents){
            	    $FormattedParts = [pscustomobject] @{
                	    "Category" = $Record.Category
                	    "CategoryNumber" = $Record.CategoryNumber
                	    "Container" = $Record.Container
                	    "Data" = $Record.Data
                	    "EntryType" = $Record.EntryType
                	    "Index" = $Record.Index
                	    "InstanceId" = $Record.InstanceId
                	    "MachineName" = $Record.MachineName
                	    "Message" = $Record.Message
                	    "ReplacementStrings" = $Record.ReplacementStrings
                	    "Site" = $Record.Site
                	    "Source" = $Record.Source
                	    "TimeGenerated" = $Record.TimeGenerated
                	    "TimeWritten" = $Record.TimeWritten
                	    "UserName" = $Record.UserName
                	    "EventID" = $Record.EventID    
            	    }
            	    $Formatted += $FormattedParts
        	    }
        	    $HumanFriendlyOutput = @()

        	    foreach($Item in ($Formatted|?{$_.replacementstrings[8] -like "*2*" -or $_.replacementstrings[8] -like "*10*"})){
                	    $HumanValuesHolder = [pscustomobject] @{
                    	    "Type" = $(if($Item.EventID -eq 4624 -and $Item.ReplacementStrings[8] -eq 2){"Local Logon"}Else{"Remote Logon"})
                    	    "Date" = $Item.TimeGenerated
                    	    "Status" = "Success"
                    	    "User" = $Item.ReplacementStrings[5]
                    	    "Computer" = $Item.ReplacementStrings[11]
                	    }
                	    $HumanFriendlyOutput += $HumanValuesHolder
        	    }
        	    $HumanFriendlyOutput | export-csv $SelectedOutputPath\LogonHistory.csv -NoTypeInformation
            }elseif($RunningAsAdmin -eq $false){write-output "You need to be running as admin to access these logs! `n";pause}
    	}

    	    Function Test-DomainCredentials{
        	[CmdletBinding()]
        	[OutputType([Bool])]
        	param (
            	[Parameter(
                	Mandatory = $true
            	)]
            	[Alias(
                	'PSCredential'
            	)]
            	[ValidateNotNull()]
            	[PSCredential]
            	$Credential,

            	[Parameter()]
            	[String]
            	$Domain = $Credential.GetNetworkCredential().Domain
        	)

        	[System.Reflection.Assembly]::LoadWithPartialName("System.DirectoryServices.AccountManagement") | Out-Null

        	$principalContext = New-Object System.DirectoryServices.AccountManagement.PrincipalContext(
            	[System.DirectoryServices.AccountManagement.ContextType]::Domain, $Domain
        	)

        	$networkCredential = $Credential.GetNetworkCredential()

        	Write-Output -InputObject $(
            	$principalContext.ValidateCredentials(
                	$networkCredential.UserName, $networkCredential.Password
            	)
        	)

        	$principalContext.Dispose()
        }

            Function Check-Credential{
            $CheckCred = Test-DomainCredentials -Credential $Credentials
            If($CheckCred -eq $true){
                    Write-Output "Credtentials entered are correct."
                }
                Else{
                    write-host "Incorrect Credentials"
                }
             Pause
    	}

            Function Get-OSInfo{
            Get-CimInstance -ClassName win32_operatingsystem | select * | export-csv $SelectedOutputPath\OperatingSystemInfo.csv -NoTypeInformation
            Write-output "Operating System information saved to $SelectedOutputPath\OperatingSystemInfo.csv) `n"
            pause
        }

            Function Get-AllServices{
            Get-CimInstance -classname Win32_Service -ComputerName $COMPUTERNAME |sort-Object state | export-csv $SelectedOutputPath\ServiceInfo.csv -NoTypeInformation
            Write-output "Services information saved to $SelectedOutputPath\ServiceInfo.csv) `n"
            pause
        }
            
            Function Get-DiskInfo {
            $disks=Get-WmiObject -Class Win32_Logicaldisk -Filter "Drivetype=3"
            $MinimumFreePercent = 10
                foreach ($disk in $disks){
                    $perFree=($disk.FreeSpace/$disk.Size)*100;
                    if ($perFree -ge $MinimumFreePercent){
                        $OK=$True
                    }else{
                        $OK=$False
                    }
                    if((test-path $SelectedOutputPath\DiskInfo.csv) -eq $false){
                        $disk|Select *,@{Name="More than 10% Space Remaining";Expression={$OK}} | export-csv $SelectedOutputPath\DiskInfo.csv -Append -NoTypeInformation
                    }else{remove-item $SelectedOutputPath\DiskInfo.csv; $disk|Select *,@{Name="More than 10% Space Remaining";Expression={$OK}} | export-csv $SelectedOutputPath\DiskInfo.csv -Append -NoTypeInformation}
                }
                Write-output "Disk information saved to $SelectedOutputPath\DiskInfo.csv) `n"
                pause
        }

            Function Get-DiskVolumeInfo{
            Write-Verbose "Getting Volume data" 
            $Data = Get-WmiObject Win32_volume 
            Foreach ($Drive in $Data) {
                Write-Verbose "Processing Volume $($Drive.name)"
                $props = @{
                    'ComputerName'=$env:COMPUTERNAME;
                    'Size'="{0:N2}" -f ($Drive.capacity/1GB)
                    'Drive'=$Drive.name;
                    'Freespace'="{0:N2}" -f ($Drive.freespace/1GB)
                }
                $Volumeinfo = New-Object -TypeName PSObject -Property $props
            }
            $VolumeInfo  | export-csv $SelectedOutputPath\DiskVolumeInfo.csv -NoTypeInformation
            Write-output "Disk Volume information saved to $SelectedOutputPath\DiskVolumeInfo.csv) `n"
            pause
        }

            Function Get-QuickComputerID{
            Write-Verbose "Starting Get-ComputerData"
            $everythingok=$true
            Write-Verbose "Querying $env:COMPUTERNAME"
            Write-Verbose "Querying Win32_Operatingsystem"
            $OS = Get-WmiObject -Class win32_operatingsystem -computername $env:COMPUTERNAME -ErrorAction stop
            Write-Verbose "Querying Win32_Computersystem"
            $CS = Get-WmiObject Win32_computersystem -computername $env:COMPUTERNAME
            Switch ($CS.AdminPasswordStatus) {
                0{$aps='NA'}
                1{$aps="Disabled"}
                2{$aps="Enabled"}
                3{$aps="Unknown"}
            }
            Write-Verbose "Querying Win32_BIOS"
            $Bios = Get-WmiObject Win32_BIOS -computername $env:COMPUTERNAME
            $props = @{'ComputerName'=$env:COMPUTERNAME;
                'Domain'=$CS.Domain;
                'OSVersion'=$os.version;
                'SPVersion'=$os.servicepackmajorversion;
                'BIOSSerial'=$bios.serialnumber;
                'Manufacturer'=$CS.manufacturer;
                'Admin Password Status'=$aps;
                'Model'=$CS.model}
            write-verbose "WMI Queries complete"
            $CompDataObj = New-Object -TypeName PSObject -Property $props
            $CompDataObj | export-csv $SelectedOutputPath\QuickComputerID.csv -NoTypeInformation
            Write-output "Basic Computer information saved to $SelectedOutputPath\QuickComputerID.csv) `n"
            Write-Output $CompDataObj
            "`n"
            pause
        }

            Function Get-GPOReport{
           & gpresult /r  | out-file (New-item -path $SelectedOutputPath\GPOReport\GPOReport.txt -Force)
           if((Test-path $SelectedOutputPath\GPOReport\GPOReport.html) -eq $true){
               remove-item $SelectedOutputPath\GPOReport\GPOReport.html
               & gpresult /h $SelectedOutputPath\GPOReport\GPOReport.html
           }else{& gpresult /h $SelectedOutputPath\GPOReport\GPOReport.html}
           Write-output "Group Polic Object Reports saved to $SelectedOutputPath\GPOReport\) `n"
           pause
        }

            Function Get-DomainUserInfo{
            $RawDomainUserInfo = net user /domain
            $Identified = ([string]($RawDomainUserInfo | select-string "       ")).Split(" ") | unique | ?{![string]::IsNullOrWhiteSpace($_)}
            $UserInfoArray = @()
            foreach($user in $Identified){
                $Data = net user $user /domain
                $LinedData = ($Data.Split([Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries) | select -skip 1 |select -skiplast 1)
                $UserData = [pscustomobject] @{
                "User name" = (($T = if(($LinedData[0] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[0] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Full Name"  = (($T = if(($LinedData[1] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[1] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Comment"  = (($T = if(($LinedData[2] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[2] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "User's comment"  = (($T = if(($LinedData[3] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[3] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Country/region code"  = (($T = if(($LinedData[4] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[4] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Account active"  = (($T = if(($LinedData[5] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[5] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Account expires"  = (($T = if(($LinedData[6] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[6] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Password last set"  = (($T = if(($LinedData[7] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[7] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Password expires"  = (($T = if(($LinedData[8] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[8] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Password changeable"  = (($T = if(($LinedData[9] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[9] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Password required"  = (($T = if(($LinedData[10] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[10] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "User may change password"  = (($T = if(($LinedData[11] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[11] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Workstations allowed"  = (($T = if(($LinedData[12] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[12] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Logon script"  = (($T = if(($LinedData[13] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[13] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "User profile"  = (($T = if(($LinedData[14] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[14] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Home directory"  = (($T = if(($LinedData[15] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[15] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Last logon"  = (($T = if(($LinedData[16] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[16] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Logon hours allowed"  = (($T = if(($LinedData[17] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[17] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Local Group Memberships"  = (($T = if(($LinedData[18] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[18] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                "Global Group memberships"  = (($T = if(($LinedData[19] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)}).count -eq 2){($LinedData[19] -split "\s\s"| ?{![string]::IsNullOrWhiteSpace($_)})[1]}else{"No Value Set"})).trim()
                }
                $UserInfoArray += $UserData
            }
            $UserInfoArray | export-csv $SelectedOutputPath\DomainUserInfo.csv -NoTypeInformation
            Write-output "User Domain Information saved to $SelectedOutputPath\DomainUserInfo.csv) `n"
            pause
        }

            Function Get-DomainControllerInfo{
            $Info = Get-ADDomainController
            $info | export-csv $SelectedOutputPath\DomainControllerInfo.csv -NoTypeInformation
            Write-output "Domain Controller Information saved to $SelectedOutputPath\DomainControllerInfo.csv) `n"
            pause
        }

            Function Get-ADUsers{
            $ADUserInfo = invoke-command -ScriptBlock{
                Get-ADUser -Properties * -Filter * | select-object 
                @{Label = "First Name";Expression = {$_.GivenName}},  
                @{Label = "Last Name";Expression = {$_.Surname}}, 
                @{Label = "Display Name";Expression = {$_.DisplayName}}, 
                @{Label = "Logon Name";Expression = {$_.sAMAccountName}}, 
                @{Label = "Full address";Expression = {$_.StreetAddress}}, 
                @{Label = "City";Expression = {$_.City}}, 
                @{Label = "State";Expression = {$_.st}}, 
                @{Label = "Post Code";Expression = {$_.PostalCode}}, 
                @{Label = "Country/Region";Expression = {if (($_.Country -eq 'USA')  ) {'United States Of America'} Else {''}}}, 
                @{Label = "Job Title";Expression = {$_.Title}}, 
                @{Label = "Company";Expression = {$_.Company}}, 
                @{Label = "Description";Expression = {$_.Description}}, 
                @{Label = "Department";Expression = {$_.Department}}, 
                @{Label = "Office";Expression = {$_.OfficeName}}, 
                @{Label = "Phone";Expression = {$_.telephoneNumber}}, 
                @{Label = "Email";Expression = {$_.Mail}}, 
                @{Label = "Manager";Expression = {$_.Manager}}, 
                @{Label = "Cell"; Expression = {$_.Mobile}},
                @{Label = "Account Status";Expression = {if (($_.Enabled -eq 'TRUE')  ) {'Enabled'} Else {'Disabled'}}},
		        @{Label = "Password Last Set";Expression={$_."passwordlastset"}}
                @{Label = "Last LogOn Date";Expression = {$_.lastlogondate}}
            }
            $ADUserInfo | select -Property * -ExcludeProperty PSComputerName,RunspaceId,PSShowComputerName | export-csv $SelectedOutputPath\ADUserInfo.csv -NoTypeInformation
            Write-output "User Domain Information saved to $SelectedOutputPath\ADUserInfo.csv) `n"
            pause
        } 

            Function Get-ADComputers{
            $Computers = Get-AdComputer -Filter * -Properties *
            $Computers | export-csv $SelectedOutputPath\ADComputerInfo.csv -NoTypeInformation
            Write-output "Domain Computer Information saved to $SelectedOutputPath\ADComputerInfo.csv) `n"
            pause
        }

            Function Get-ADGroups{
            $Groups = Get-ADGroup -Filter * -Properties *
            $Groups | export-csv $SelectedOutputPath\ADGroups.csv -NoTypeInformation
            Write-output "Domain Computer Information saved to $SelectedOutputPath\ADGroups.csv) `n"
            pause
        }

            Function Get-NetworkDeviceDNSInfo{
                Write-Host "This can take some time to complete!"                
                $Computers = (([ADSISearcher]"(&(objectClass=computer)(name=*))").FindAll()).path -split("ldap://cn=") | ?{![string]::IsNullOrWhiteSpace($_)}
                $ComputersArray = @()
                $DNSInfo = @()
                foreach($Item in $Computers){
                    $SplitPos = $Item.IndexOf(",")
                    $NameOnly = $Item.Substring(0, $SplitPos)
                    $ComputersArray += $NameOnly
                }
                foreach($Computer in $ComputersArray){
                    $Responded = Resolve-DNSName -name "$Computer" -ErrorAction SilentlyContinue -type All
                    $DNSInfo += $Responded
                }
                $DNSInfo | export-csv $SelectedOutputPath\DomainComputerDNSInfo.csv -NoTypeInformation
                Write-output "Domain Computer DNS Information saved to $SelectedOutputPath\DomainComputerDNSInfo.csv) `n"
                pause
            }

            Function Choose-Ports{
                Do{
                $OptionsInput = @(
                "Check top 1000 ports (Can Take a while to complete)"
                "Check Most common ports"
                "Return to tool menu"
                )
                "Network Scanning Can Take significate time Depending on how many devices are on the network"
                "`n"

                ToolSelectionMenu($OptionsInput)
                $Choice = Read-Host "Please select an option"
                        
                if($choice -eq "1" -or $choice -eq "01"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-PortScan($Choice);$Choice = "$($OptionsInput.count)"}
                if($choice -eq "2" -or $choice -eq "02"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-PortScan($Choice);$Choice = "$($OptionsInput.count)"}
                $Choice = "$($OptionsInput.count)"
            }Until($Choice -eq "$($OptionsInput.count)")
            }

            Function Get-PortScan($Choice){
                Write-Output "Beginning Scan"
                $Computers = (([ADSISearcher]"(&(objectClass=computer)(name=*))").FindAll()).path -split("ldap://cn=") | ?{![string]::IsNullOrWhiteSpace($_)}
                $ComputersArray = @()
                $DNSInfo = @()
                $Sockets = @()
                $OpenPorts = @()
                [int[]]$FullTCPPorts = 1,3,4,6,7,9,13,17,19,20,21,22,23,24,25,26,30,32,33,37,42,43,49,53,70,79,80,81,82,83,84,85,88,89,90,99,100,106,109,110,111,113,119,125,135,139,143,144,146,161,163,179,199,211,212,222,254,255,256,259,264,280,301,306,311,340,366,389,406,407,416,417,425,427,443,444,445,458,464,465,481,497,500,512,513,514,515,524,541,543,544,545,548,554,555,563,587,593,616,617,625,631,636,646,648,666,667,668,683,687,691,700,705,711,714,720,722,726,749,765,777,783,787,800,801,808,843,873,880,888,898,900,901,902,903,911,912,981,987,990,992,993,995,999,1000,1001,1002,1007,1009,1010,1011,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,1100,1102,1104,1105,1106,1107,1108,1110,1111,1112,1113,1114,1117,1119,1121,1122,1123,1124,1126,1130,1131,1132,1137,1138,1141,1145,1147,1148,1149,1151,1152,1154,1163,1164,1165,1166,1169,1174,1175,1183,1185,1186,1187,1192,1198,1199,1201,1213,1216,1217,1218,1233,1234,1236,1244,1247,1248,1259,1271,1272,1277,1287,1296,1300,1301,1309,1310,1311,1322,1328,1334,1352,1417,1433,1434,1443,1455,1461,1494,1500,1501,1503,1521,1524,1533,1556,1580,1583,1594,1600,1641,1658,1666,1687,1688,1700,1717,1718,1719,1720,1721,1723,1755,1761,1782,1783,1801,1805,1812,1839,1840,1862,1863,1864,1875,1900,1914,1935,1947,1971,1972,1974,1984,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2013,2020,2021,2022,2030,2033,2034,2035,2038,2040,2041,2042,2043,2045,2046,2047,2048,2049,2065,2068,2099,2100,2103,2105,2106,2107,2111,2119,2121,2126,2135,2144,2160,2161,2170,2179,2190,2191,2196,2200,2222,2251,2260,2288,2301,2323,2366,2381,2382,2383,2393,2394,2399,2401,2492,2500,2522,2525,2557,2601,2602,2604,2605,2607,2608,2638,2701,2702,2710,2717,2718,2725,2800,2809,2811,2869,2875,2909,2910,2920,2967,2968,2998,3000,3001,3003,3005,3006,3007,3011,3013,3017,3030,3031,3052,3071,3077,3128,3168,3211,3221,3260,3261,3268,3269,3283,3300,3301,3306,3322,3323,3324,3325,3333,3351,3367,3369,3370,3371,3372,3389,3390,3404,3476,3493,3517,3527,3546,3551,3580,3659,3689,3690,3703,3737,3766,3784,3800,3801,3809,3814,3826,3827,3828,3851,3869,3871,3878,3880,3889,3905,3914,3918,3920,3945,3971,3986,3995,3998,4000,4001,4002,4003,4004,4005,4006,4045,4111,4125,4126,4129,4224,4242,4279,4321,4343,4443,4444,4445,4446,4449,4550,4567,4662,4848,4899,4900,4998,5000,5001,5002,5003,5004,5009,5030,5033,5050,5051,5054,5060,5061,5080,5087,5100,5101,5102,5120,5190,5200,5214,5221,5222,5225,5226,5269,5280,5298,5357,5405,5414,5431,5432,5440,5500,5510,5544,5550,5555,5560,5566,5631,5633,5666,5678,5679,5718,5730,5800,5801,5802,5810,5811,5815,5822,5825,5850,5859,5862,5877,5900,5901,5902,5903,5904,5906,5907,5910,5911,5915,5922,5925,5950,5952,5959,5960,5961,5962,5963,5987,5988,5989,5998,5999,6000,6001,6002,6003,6004,6005,6006,6007,6009,6025,6059,6100,6101,6106,6112,6123,6129,6156,6346,6389,6502,6510,6543,6547,6565,6566,6567,6580,6646,6666,6667,6668,6669,6689,6692,6699,6779,6788,6789,6792,6839,6881,6901,6969,7000,7001,7002,7004,7007,7019,7025,7070,7100,7103,7106,7200,7201,7402,7435,7443,7496,7512,7625,7627,7676,7741,7777,7778,7800,7911,7920,7921,7937,7938,7999,8000,8001,8002,8007,8008,8009,8010,8011,8021,8022,8031,8042,8045,8080,8081,8082,8083,8084,8085,8086,8087,8088,8089,8090,8093,8099,8100,8180,8181,8192,8193,8194,8200,8222,8254,8290,8291,8292,8300,8333,8383,8400,8402,8443,8500,8600,8649,8651,8652,8654,8701,8800,8873,8888,8899,8994,9000,9001,9002,9003,9009,9010,9011,9040,9050,9071,9080,9081,9090,9091,9099,9100,9101,9102,9103,9110,9111,9200,9207,9220,9290,9415,9418,9485,9500,9502,9503,9535,9575,9593,9594,9595,9618,9666,9876,9877,9878,9898,9900,9917,9929,9943,9944,9968,9998,9999,10000,10001,10002,10003,10004,10009,10010,10012,10024,10025,10082,10180,10215,10243,10566,10616,10617,10621,10626,10628,10629,10778,11110,11111,11967,12000,12174,12265,12345,13456,13722,13782,13783,14000,14238,14441,14442,15000,15002,15003,15004,15660,15742,16000,16001,16012,16016,16018,16080,16113,16992,16993,17877,17988,18040,18101,18988,19101,19283,19315,19350,19780,19801,19842,20000,20005,20031,20221,20222,20828,21571,22939,23502,24444,24800,25734,25735,26214,27000,27352,27353,27355,27356,27715,28201,30000,30718,30951,31038,31337,32768,32769,32770,32771,32772,32773,32774,32775,32776,32777,32778,32779,32780,32781,32782,32783,32784,32785,33354,33899,34571,34572,34573,35500,38292,40193,40911,41511,42510,44176,44442,44443,44501,45100,48080,49152,49153,49154,49155,49156,49157,49158,49159,49160,49161,49163,49165,49167,49175,49176,49400,49999,50000,50001,50002,50003,50006,50300,50389,50500,50636,50800,51103,51493,52673,52822,52848,52869,54045,54328,55055,55056,55555,55600,56737,56738,57294,57797,58080,60020,60443,61532,61900,62078,63331,64623,64680,65000,65129,65389
                [int[]]$ShortTCPPorts = 1,3,4,6,7,9,13,17,19,20,21,22,23,24,25,26,30,32,33,37,42,43,49,53,70,79,80,81,82,83,84,85,88,89,90,99,100,106,109,110,111,113,119,125,135,139,143,144,146,161,163,179,199,211,212,222,254,255,256,259,264,280,301,306,311,340,366,389,406,407,416,417,425,427,443,444,445,458,464,465,481,497,500,512,513,514,515,524,541,543,544,545,548,554,555,563,587,593,616,617,625,631,636

                if($Choice -eq 1){$TCPPortsChoice = $FullTCPPorts}else{$TCPPortsChoice = $ShortTCPPorts}

                foreach($Item in $Computers){
                    $SplitPos = $Item.IndexOf(",")
                    $NameOnly = $Item.Substring(0, $SplitPos)
                    $ComputersArray += $NameOnly
                }
                    foreach($Computer in $ComputersArray){ #$host.EnterNestedPrompt()
                        Foreach($port in $TCPPortsChoice){ 
                            $Socket = New-Object System.Net.Sockets.TcpClient
                            $Connection = $Socket.BeginConnect($computer,$port,$null,$null)
                            #$host.EnterNestedPrompt()
                            start-sleep -Milliseconds 100
                            if(($Socket.Connected) -eq "True"){
                                $SocketInfo = [pscustomobject] @{
                                    "Computer Name"       = $Computer
                                    "Port Open"           = $Port
                                    "Client"              = $Socket.Client
                                    "Available"           = $Socket.Available
                                    "Connected"           = $Socket.Connected
                                    "ExclusiveAddressUse" = $Socket.ExclusiveAddressUse
                                    "ReceiveBufferSize"   = $Socket.ReceiveBufferSize
                                    "SendBufferSize"      = $Socket.SendBufferSize
                                    "ReceiveTimeout"      = $Socket.ReceiveTimeout
                                    "SendTimeout"         = $Socket.SendTimeout
                                    "LingerState"         = $Socket.LingerState
                                    "NoDelay"             = $Socket.NoDelay
                                }
                                write-host "Port $Port is open on $computer - Adding to Report"
                            $Socket.EndConnect($Connection)
                            $OpenPorts += $SocketInfo
                            $Sockets += $Socket
                            }
                        }
                   }
                $openports | export-csv $SelectedOutputPath\NetworkScanResults.csv -NoTypeInformation
                "`n"
                Write-output "Domain Computer DNS Information saved to $SelectedOutputPath\NetworkScanResults.csv) `n"
                pause
            }

    	<# END Setup Environment #>
   	 
	}
	<# End Begin Section #>

	<# Start Process Section #>
	Process{
    
    	<# End Main function Delerations #>

    	<# Start Main Section Selection #>
   	 
    	<# Starting Do Loop. This is the main action section of the program #>
        Do{

    	<# Call Main Menu Display to start user choices #>
            $MainMenuOptions = @(
            	"User Enumeration"
            	"Machine Enumeration"
            	"Domain Enumeration"
            	"Network Enumeration"
            	#"Evasion/Confusion"
            	#"Exfiltration"
                "Enter Interactive Shell"
            	"End Program"
        	)

        	MainMenu($MainMenuOptions)
   	 
    	<# Display error if needed or wanted Not expected at all levels #>
        	($Script:InputError | write-host -ForegroundColor Red)

    	<# Get User input to navigate menues #>
        	$MainMenuSelection = Read-host "Please selct an option"

    	<# If 1 is pressed for the User Enumeration Section #>
        	If($MainMenuSelection -eq 1 -or $MainMenuSelection -eq "01"){

        	<# Start Loop for menu control #>
            	do{
                	<# This clear ensures we are working with a clean display #>    
                	clear
                	<# Predefined list of available tools #>
                	$OptionsInput = @(
                    	"Copy Web browser Caches for Current User"
                    	"Check powershell command history"
                    	"Enum Installed applications"
                    	"Pull WIFI Profile keys"
                    	"Get Logon Records (Requires Admin Privilege)"
                    	"Test Domain Credentials"
                        "Enter Interactive Shell"
                    	"Return to main menu"
                	)
               	 
                	<# Display Menu #>
                	ToolSelectionMenu($OptionsInput)
               	 
                	<# Get User Input #>
                	$choice = read-host "Select a tool"

                	<# Break out of options selected calling their actions or further menus #>
                	if($choice -eq "1" -or $choice -eq "01"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Copy-Caches}
                	if($choice -eq "2" -or $choice -eq "02"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-POSHHistory}
                	if($choice -eq "3" -or $choice -eq "03"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-InstalledApps}
                	if($choice -eq "4" -or $choice -eq "04"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-WiFiProfiles}
                	if($choice -eq "5" -or $choice -eq "05"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-LogonHistory}
                	if($choice -eq "6" -or $choice -eq "06"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Check-Credential}
                    if($choice -eq "$($OptionsInput.count-1)" -or $choice -eq"0$($OptionsInput.count-1)"){clear; write-output "Option $choice Selected: $($OptionsInput[$choice-1])"; $host.EnterNestedPrompt()}

            	}until($choice -eq "$($OptionsInput.count)")
        	}

    	<# If 2 is pressed for the Machine Enumeration Section #>
        	If($MainMenuSelection -eq 2 -or $MainMenuSelection -eq "02"){
                do{
                    <# This clear ensures we are working with a clean display #>    
                	clear
                	<# Predefined list of available tools #>
                	$OptionsInput = @(
                        "OS-Info"
                        "Installed services"
                        "Disk-Info"
                        "Disk Volume-Info"
                        "Computer ID Essentials"
                        "Get GPO Report"
                        "Enter Interactive Shell"
                        "Return to main menu"
                	)
               	 
                	<# Display Menu #>
                	ToolSelectionMenu($OptionsInput)
               	 
                	<# Get User Input #>
                	$choice = read-host "Select a tool"

                	<# Break out of options selected calling their actions or further menus #>
                	if($choice -eq "1" -or $choice -eq "01"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-OSInfo}
                	if($choice -eq "2" -or $choice -eq "02"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-AllServices}
                	if($choice -eq "3" -or $choice -eq "03"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-DiskInfo}
                	if($choice -eq "4" -or $choice -eq "04"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-DiskVolumeInfo}
                	if($choice -eq "5" -or $choice -eq "05"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-QuickComputerID}
                    if($choice -eq "6" -or $choice -eq "06"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-GPOReport}
                    if($choice -eq "$($OptionsInput.count-1)" -or $choice -eq"0$($OptionsInput.count-1)"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; $host.EnterNestedPrompt()}

            }until($choice -eq "$($OptionsInput.count)")
        }

        <# If 3 is pressed for the Machine Enumeration Section #>
        	If($MainMenuSelection -eq 3){
                do{
                    <# This clear ensures we are working with a clean display #>    
                	clear
                	<# Predefined list of available tools #>
                	$OptionsInput = @(
                        "Get Domain Users (Network Query)"
                        "Get Domain Controller Info (Requires Domain Privileges)"
                        "Get AD Users (Requires Domain Privileges)"
                        "Get AD Computers (Requires Domain Privileges)"
                        "Get AD Groups(Requires Domain Privileges)"
                        "Enter Interactive Shell"
                        "Return to main menu"
                	)
               	 
                	<# Display Menu #>
                	ToolSelectionMenu($OptionsInput)
               	 
                	<# Get User Input #>
                	$choice = read-host "Select a tool"

                	<# Break out of options selected calling their actions or further menus #>
                	if($choice -eq "1" -or $choice -eq "01"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-DomainUserInfo}
                	if($choice -eq "2" -or $choice -eq "02"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-DomainControllerInfo}
                	if($choice -eq "3" -or $choice -eq "03"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-ADUsers}
                	if($choice -eq "4" -or $choice -eq "04"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-ADComputers}
                	if($choice -eq "5" -or $choice -eq "05"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-ADGroups}
                    if($choice -eq "$($OptionsInput.count-1)" -or $choice -eq"0$($OptionsInput.count-1)"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; $host.EnterNestedPrompt()}

            }until($choice -eq "$($OptionsInput.count)")
        }

        <# If 4 is pressed for the Network Enumeration Section #>
        	If($MainMenuSelection -eq 4){
                do{
                    <# This clear ensures we are working with a clean display #>    
                	clear
                	<# Predefined list of available tools #>
                	$OptionsInput = @(
                        "Get Network Device DNS Info"
                        "Port Scan Network Computers"
                        "Enter Interactive Shell"
                        "Return to main menu"
                	)
               	 
                	<# Display Menu #>
                	ToolSelectionMenu($OptionsInput)
               	 
                	<# Get User Input #>
                	$choice = read-host "Select a tool"

                	<# Break out of options selected calling their actions or further menus #>
                	if($choice -eq "1" -or $choice -eq "01"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Get-NetworkDeviceDNSInfo}
                	if($choice -eq "2" -or $choice -eq "02"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; Choose-Ports}
                	#if($choice -eq "3" -or $choice -eq "03"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; }
                	#if($choice -eq "4" -or $choice -eq "04"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; }
                	#if($choice -eq "5" -or $choice -eq "05"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; }
                    if($choice -eq "$($OptionsInput.count-1)" -or $choice -eq"0$($OptionsInput.count-1)"){clear; write-verbose "Option $choice Selected: $($OptionsInput[$choice-1])"; "`n"; $host.EnterNestedPrompt()}

            }until($choice -eq "$($OptionsInput.count)")
        }
            
        <# If 7 is pressed for the Interpreter Shell #>    
            If($MainMenuSelection -eq ($MainMenuOptions.count)-1){
                do{
            	    $host.EnterNestedPrompt()
                    $Exit = '0'
                }until($Exit -eq '0')}

    	}Until($MainMenuSelection -eq ($MainMenuOptions.count) -or $MainMenuSelection -eq "0$($MainMenuOptions.count)")
    	<# Ending Do Loop. This was the main action section of the program #>

	}
	<# END Process Section #>

	<# Start End Section #>
	End{}
	<# End End Section #>
    
}

Run-BootCampFinalProject





