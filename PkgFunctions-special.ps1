Function mod-adoptopenjdk8 ($obj) {
#need to deal with casing issues
#need to deal with added added param that has option of install both 32 and 64, 
	remove-item -ea 0 -Path (get-childitem $obj.toolsDir -Filter "*hoco*stall.ps1")
	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url = ").tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url64bit = ").tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'file64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n    $filePath64"

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-adoptopenjdk8jre ($obj) {
#need to deal with casing issues
#need to deal with added added param that has option of install both 32 and 64, 
	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url = ").tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url64bit = ").tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()

	$filePath32 = 'file     = (Join-Path $toolsDir2 "' + $filename32 + '")'
	$filePath64 = 'file64	= (Join-Path $toolsDir2 "' + $filename64 + '")'


	$obj.installScriptMod = '$toolsDir2   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n    $filePath64"


	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-adoptopenjdkjre ($obj) {
#need to deal with casing issues
#need to deal with added added param that has option of install both 32 and 64, 
	remove-item -ea 0 -Path (get-childitem $obj.toolsDir -Filter "*hoco*stall.ps1")
	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url = ").tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url64bit = ").tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'file64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n  $filePath32`n  $filePath64"


	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-sysinternals ($obj) {
	$fullurl = ($obj.installScriptOrig -split "`n" | Select-String -Pattern ' url ').tostring()
	$fullurlnano = ($obj.installScriptOrig -split "`n" | Select-String -Pattern 'Args.url ').tostring()

	$url = ($fullurl -split "'" | Select-String -Pattern "http").tostring()
	$urlnano = ($fullurlnano -split "'" | Select-String -Pattern "http").tostring()

	$filename = ($url -split "/" | Select-Object -Last 1).tostring()
	$filenamenano = ($urlnano -split "/" | Select-Object -Last 1).tostring()

	$filePath = 'FileFullPath  = (Join-Path $toolsPath "' + $filename + '")'
	$filePathnano = '$packageArgs.FileFullPath = (Join-Path $toolsPath "' + $filenamenano + '")'

	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace 'unzipLocation' , 'Destination  '
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyZipPackage" , "Get-ChocolateyUnzip"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n  $filePath"
	$obj.installScriptMod = $obj.installScriptMod -replace "Is-NanoServer.*" , "$&`n  $filepathnano"

	download-fileBoth -url32 $url -url64 $urlnano -filename32 $filename -filename64 $filenamenano -toolsDir $obj.toolsDir
}


Function mod-virtualbox ($obj) {
	$obj.toolsDir = $obj.versionDir
	
 	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern " Url .*http").tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern " Url64bit ").tostring()
	$fullurlep = ($obj.installScriptOrig -split "`n" | Select-String -pattern '\$Url_ep .*http').tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()
	$urlep = ($fullurlep -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring().replace(".exe" , "-x64.exe")
	$filenameep = ($urlep -split "/" | Select-Object -Last 1).tostring()

	$filePath32 = 'file          = (Join-Path $toolsPath "' + $filename32 + '")'
	$filePath64 = 'file64        = (Join-Path $toolsPath "' + $filename64 + '")'
	$filePathep = '(Join-Path $toolsPath "' + $filenameep + '")'

	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n  $filePath32`n  $filePath64"
	$obj.installScriptMod = $obj.installScriptMod -replace "Get-ChocolateyWebFile" , "<# Get-ChocolateyWebFile"
	$obj.installScriptMod = $obj.installScriptMod -replace "ChecksumType64 *'sha256'" , "$& #>"
	$obj.installScriptMod = $obj.installScriptMod -replace "file_path_ep.*Get-Package.*" , "file_path_ep = $filepathep"
	
	$exeRemoveString = "`n" + 'Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }'
	$obj.installScriptMod = $obj.installScriptMod + $exeRemoveString


	
	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
	download-fileSingle -url $urlep -filename $filenameep -toolsDir $obj.toolsDir
}


#moving here as this should be outdated now
Function mod-nextcloud-client ($obj) {

	$version = $obj.version

	$url32 = "https://download.nextcloud.com/desktop/releases/Windows/Nextcloud-" + $version + "-setup.exe"
	$filename32 = "Nextcloud-" + $version + "-setup.exe"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n   $filePath32"



	#$dlwdFile32 = (Join-Path $obj.toolsDir "$filename32")

 	#$dlwd = New-Object net.webclient

	if (Test-Path $dlwdFile32) {
		Write-Output $dlwdFile32 ' appears to be downloaded'
	} else {
		#$dlwd.DownloadFile($url32, $dlwdFile32)
		#invoke webrequest needed as with it downloadfile it 429s
		Invoke-WebRequest -Uri $url32 -OutFile $dlwdFile32
	}
	


	#$dlwd.dispose()
}


Function mod-hwmonitor ($obj) {

	$version = $obj.version

	$url32 = "http://download.cpuid.com/hwmonitor/hwmonitor_" + $version + ".exe"
	$filename32 = "hwmonitor_" + $version + ".exe"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n   $filePath32"



	#$dlwdFile32 = (Join-Path $obj.toolsDir "$filename32")

 	#$dlwd = New-Object net.webclient

	if (Test-Path $dlwdFile32) {
		Write-Output $dlwdFile32 ' appears to be downloaded'
	} else {
		#$dlwd.DownloadFile($url32, $dlwdFile32)
		#invoke webrequest needed as with it downloadfile it 429s
		Invoke-WebRequest -Uri $url32 -OutFile $dlwdFile32
	}

	#$dlwd.dispose()
}


Function mod-nvidia-driver ($obj) {
	$fullurlwin7  = ($obj.installScriptOrig -split "`n" | Select-String -pattern "packageArgs\['url64'\]      = 'https").tostring()
	$fullurlwin10 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url64   ").tostring()
	$fullurlDCH   = ($obj.installScriptOrig -split "`n" | Select-String -pattern "packageArgsDCHURL      = 'https").tostring()

	$urlwin7  = ($fullurlwin7 -split "'" | Select-String -Pattern "http").tostring()
	$urlwin10 = ($fullurlwin10 -split "'" | Select-String -Pattern "http").tostring()
	$urlDCH   = ($fullurlDCH -split "'" | Select-String -Pattern "http").tostring()

	$filenamewin7  = ($urlwin7 -split "/" | Select-Object -Last 1).tostring()
	$filenamewin10 = ($urlwin10 -split "/" | Select-Object -Last 1).tostring()
	$filenameDCH   = ($urlDCH  -split "/" | Select-Object -Last 1).tostring()

	$filePathwin7  = '$packageArgs[''file'']    =  (Join-Path $toolsDir "' + $filenamewin7 + '")'
	$filePathwin10 = '    file    = (Join-Path $toolsDir "' + $filenamewin10 + '")'
	$filePathDCH   = '$packageArgs[''file'']    = (Join-Path $toolsDir "' + $filenameDCH + '")'

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace '\$packageArgs\[''file''\] = "\$\{' , "#$&"
	#$obj.installScriptMod = $obj.installScriptMod -replace '^\$packageArgs\[''file''\].*=.*"\$\{ENV' , '#'
	#'^$packageArgs.{5,30}nvidiadriver'   , '#$&'

	$obj.installScriptMod = $obj.installScriptMod -replace "Get-ChocolateyWebFile" , "#$&"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n $filePathwin10"
	$obj.installScriptMod = $obj.installScriptMod -replace "OSVersion\.Version\.Major -ne '10' \) \{" , "$&`n    $filePathwin7"
	$obj.installScriptMod = $obj.installScriptMod -replace "-eq 'true'\) \{" , "$&`n    $filePathDCH"

	$dlwdFilewin7 = (Join-Path $obj.toolsDir "$filenamewin7")
	$dlwdFilewin10 = (Join-Path $obj.toolsDir "$filenamewin10")
	$dlwdFileDCH = (Join-Path $obj.toolsDir "$filenameDCH")

	$dlwd = New-Object net.webclient

	if (Test-Path $dlwdFilewin7) {
		Write-Output $dlwdFilewin7 ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlwin7, $dlwdFilewin7)
	}

	if (Test-Path $dlwdFilewin10) {
		Write-Output $dlwdFilewin10 ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlwin10, $dlwdFilewin10)
	}

	if (Test-Path $dlwdFileDCH) {
		Write-Output $dlwdFileDCH ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlDCH, $dlwdFileDCH)
	}

	$dlwd.dispose()

}


Function mod-geforce-driver ($obj) {
	$fullurlwin7  = ($obj.installScriptOrig -split "`n" | Select-String -pattern "packageArgs\['url64'\]      = 'https").tostring()
	$fullurlwin10 = ($obj.installScriptOrig -split "`n" | Select-String -pattern "Url64   ").tostring()
	$fullurlDCH   = ($obj.installScriptOrig -split "`n" | Select-String -pattern "packageArgsDCHURL      = 'https").tostring()

	$urlwin7  = ($fullurlwin7 -split "'" | Select-String -Pattern "http").tostring()
	$urlwin10 = ($fullurlwin10 -split "'" | Select-String -Pattern "http").tostring()
	$urlDCH   = ($fullurlDCH -split "'" | Select-String -Pattern "http").tostring()

	$filenamewin7  = ($urlwin7 -split "/" | Select-Object -Last 1).tostring()
	$filenamewin10 = ($urlwin10 -split "/" | Select-Object -Last 1).tostring()
	$filenameDCH   = ($urlDCH  -split "/" | Select-Object -Last 1).tostring()

 	$filePathwin7  = '$packageArgs[''file64'']    =  (Join-Path $toolsDir "' + $filenamewin7 + '")'
	$filePathwin10 = '    file64    = (Join-Path $toolsDir "' + $filenamewin10 + '")'
	$filePathDCH   = '$packageArgs[''file64'']    = (Join-Path $toolsDir "' + $filenameDCH + '")'
	
	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n $filePathwin10"
	$obj.installScriptMod = $obj.installScriptMod -replace "OSVersion\.Version\.Major -ne '10' \) \{" , "$&`n    $filePathwin7"
	$obj.installScriptMod = $obj.installScriptMod -replace "-eq 'true'\) \{" , "$&`n    $filePathDCH"

	$dlwdFilewin7 = (Join-Path $obj.toolsDir "$filenamewin7")
	$dlwdFilewin10 = (Join-Path $obj.toolsDir "$filenamewin10")
	$dlwdFileDCH = (Join-Path $obj.toolsDir "$filenameDCH")
	
	Write-Output "Downloading geforce-game-ready-driver files"
	$dlwd = New-Object net.webclient

	if (Test-Path $dlwdFilewin7) {
		Write-Output $dlwdFilewin7 ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlwin7, $dlwdFilewin7)
	}

	if (Test-Path $dlwdFilewin10) {
		Write-Output $dlwdFilewin10 ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlwin10, $dlwdFilewin10)
	}

	if (Test-Path $dlwdFileDCH) {
		Write-Output $dlwdFileDCH ' appears to be downloaded'
	} else {
		$dlwd.DownloadFile($urlDCH, $dlwdFileDCH)
	}

	$dlwd.dispose()

}


Function mod-ds4windows ($obj) {
	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$Url ').tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$Url64 ').tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()

	$filePath32 = 'FileFullPath     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'FileFullPath64	= (Join-Path $toolsDir "' + $filename64 + '")'

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "#>`n`nInstall-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n    $filePath64"
	$obj.installScriptMod = $obj.installScriptMod -replace "if \(\-not" , "<#if \(\-not"

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir

}


Function mod-adobereader ($obj) {
	$secondDir = (Join-Path $obj.toolsDir 'tools')
	If (Test-Path $secondDir) {
		Get-Childitem -Path $secondDir |  Move-Item -Destination $obj.toolsDir
		Remove-Item $secondDir -ea 0 -force
	}

	$MUIurlFull    = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$MUIurl ').tostring()
	$MUImspURLFull = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$MUImspURL ').tostring()

	$MUIurl   = ($MUIurlFull    -split "'" | Select-String -Pattern "http").tostring()
	$MUImspURL = ($MUImspURLFull -split "'" | Select-String -Pattern "http").tostring()

	$filenameMUI = ($MUIurl -split "/" | Select-Object -Last 1).tostring()
	$filenameMSP = ($MUImspURL -split "/" | Select-Object -Last 1).tostring()

	$muiPath = '$MUIexePath = (Join-Path $toolsDir "' + $filenameMUI + '")'
	$mspPath = '$mspPath    = (Join-Path $toolsDir "' + $filenameMSP + '")'


	$obj.installScriptMod = $muiPath + "`n" + $mspPath + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace '\$DownloadArgs' , '<# $DownloadArgs'
	$obj.installScriptMod = $obj.installScriptMod -replace '@DownloadArgs' , '$& #>'
	$obj.installScriptMod = $obj.installScriptMod + "`n" + 'Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }'

	Write-Output $obj.toolsDir

	download-fileBoth -url32 $MUIurl -url64 $MUImspURL -filename32 $filenameMUI -filename64 $filenameMSP -toolsDir $obj.toolsDir
}


Function mod-ssms ($obj) {
	$fullurlfull    = ($obj.installScriptOrig -split "`n" | Select-String -pattern '\$fullUrl =').tostring()
	$fullurlupgrade = ($obj.installScriptOrig -split "`n" | Select-String -pattern '\$upgradeUrl =').tostring()

	$urlfull    = ($fullurlfull    -split "'" | Select-String -Pattern "http").tostring()
	$urlupgrade = ($fullurlupgrade -split "'" | Select-String -Pattern "http").tostring()

	$filenamefull    = ($urlfull    -split "/" | Select-Object -Last 1).tostring()
	$filenameupgrade = ($urlupgrade -split "/" | Select-Object -Last 1).tostring()

	$filePathfull    = '$packageArgs.file    = (Join-Path $toolsDir "' + $filenamefull + '")'
	$filePathupgrade = '$packageArgs.file    = (Join-Path $toolsDir "' + $filenameupgrade + '")'
	$filePathEmpty   = "file          = ''"

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n  $filePathEmpty"
	$obj.installScriptMod = $obj.installScriptMod -replace "ssms180\) {" , "$&`n    $filePathUpgrade"
	$obj.installScriptMod = $obj.installScriptMod -replace "} else {" , "$&`n    $filePathFull"
	
	$exeRemoveString = "`n" + 'Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }'
	$obj.installScriptMod = $obj.installScriptMod + $exeRemoveString

	download-fileBoth -url32 $urlfull -url64 $urlupgrade -filename32 $filenamefull -filename64 $filenameupgrade -toolsDir $obj.toolsDir
}


Function mod-thunderbird ($obj) {
	$version = $obj.version

	$url32 = "https://download.mozilla.org/?product=thunderbird-" + $version + "-SSL&os=win&lang=en-US"
	$url64 = "https://download.mozilla.org/?product=thunderbird-" + $version + "-SSL&os=win64&lang=en-US"

	$filename32 = "Thunderbird-Setup-" + $version + ".exe"
	$filename64 = "Thunderbird-Setup-x64-" + $version + ".exe"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = '$packageArgs.file64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n"
    $obj.installScriptMod = $obj.installScriptMod -replace "Get-OSArchitectureWidth 64\)\) {" , "$&`n   $filePath64`n"
	
	$exeRemoveString = "`n" + 'Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }'
	$obj.installScriptMod = $obj.installScriptMod + $exeRemoveString



	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-firefox ($obj) {

	$version = $obj.version

	$url32 = "https://download.mozilla.org/?product=firefox-" + $version + "-ssl&os=win&lang=en-US"
	$url64 = "https://download.mozilla.org/?product=firefox-" + $version + "-ssl&os=win64&lang=en-US"

	$filename32 = "Firefox-Setup-" + $version + ".exe"
	$filename64 = "Firefox-Setup-x64-" + $version + ".exe"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = '$packageArgs.file64	= (Join-Path $toolsDir "' + $filename64 + '")'

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n"
    $obj.installScriptMod = $obj.installScriptMod -replace "Get-OSArchitectureWidth 64\)\) {" , "$&`n   $filePath64`n"

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-vcredist140 ($obj) {

	$dataFile = Join-Path $obj.toolsDir 'data.ps1'
	$dataContent = Get-Content $datafile
	

	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	
 	$fullurl32 = ($dataContent -split "`n" | Select-String -pattern ' Url ').tostring()
	$fullurl64 = ($dataContent -split "`n" | Select-String -pattern ' Url64 ').tostring()
	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()
	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()
	$filePath32 = 'File    = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'File64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$dataContent = $dataContent -replace "installData32 = @{" , "$&`n  $filePath32"
	$dataContent = $dataContent -replace "installData64 = @{" , "$&`n  $filePath64"


	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
	
	Set-Content -Value $dataContent -Path $dataFile
	
}


#Special because orig script uses $version instead of a full URL
Function mod-powershell-core ($obj) {
	$version = $obj.version

	$url32 = "https://github.com/PowerShell/PowerShell/releases/download/v" + $version + "/PowerShell-" + $version + "-win-x86.msi"
	$url64 = "https://github.com/PowerShell/PowerShell/releases/download/v" + $version + "/PowerShell-" + $version + "-win-x64.msi"
	$filename32 = "PowerShell-" + $version + "-win-x86.msi"
	$filename64 = "PowerShell-" + $version + "-win-x64.msi"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'file64	= (Join-Path $toolsDir "' + $filename64 + '")'

	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "Install-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n    $filePath64"

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


#TODO- import functions from real file to get url if package is not latest version
Function mod-libreoffice-fresh ($obj) {

	$version = $obj.version

	# $fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern 'url  ').tostring()
	# $fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern 'url64bit ').tostring()

	# $url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	# $url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	# $filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring()
	# $filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring()

	$url32 = "https://download.documentfoundation.org/libreoffice/stable/" + $version + "/win/x86/LibreOffice_" + $version + "_Win_x86.msi"
	$url64 = "https://download.documentfoundation.org/libreoffice/stable/" + $version + "/win/x86_64/LibreOffice_" + $version + "_Win_x64.msi"
	$filename32 = "LibreOffice_" + $version + "_Win_x86.msi"
	$filename64 = "LibreOffice_" + $version + "_Win_x64.msi"

	$filePath32 = 'file     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = 'file64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "#>`n`nInstall-ChocolateyInstallPackage"
	$obj.installScriptMod = $obj.installScriptMod -replace "packageArgs = @{" , "$&`n    $filePath32`n    $filePath64"
	$obj.installScriptMod = $obj.installScriptMod -replace "if \(\-not" , "<#if \(\-not"

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir
}


Function mod-hexchat ($obj) {
	$fullurl32 = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$Url ').tostring()
	$fullurl64 = ($obj.installScriptOrig -split "`n" | Select-String -pattern '^\$Url64 ').tostring()

	$url32 = ($fullurl32 -split "'" | Select-String -Pattern "http").tostring()
	$url64 = ($fullurl64 -split "'" | Select-String -Pattern "http").tostring()

	$filename32 = ($url32 -split "/" | Select-Object -Last 1).tostring().replace('%20', '-')
	$filename64 = ($url64 -split "/" | Select-Object -Last 1).tostring().replace('%20', '-')

	$filePath32 = '$File     = (Join-Path $toolsDir "' + $filename32 + '")'
	$filePath64 = '$File64	= (Join-Path $toolsDir "' + $filename64 + '")'


	$obj.installScriptMod = "$filePath32`n$filePath64`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = '$ErrorActionPreference = ''Stop''' + "`n" + $obj.InstallScriptMod
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyPackage" , "#Install-ChocolateyPackage"
	$obj.installScriptMod = $obj.installScriptMod + "`n" + 'Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$file" "$file64" -validExitCodes $validExitCodes'

	$exeRemoveString =	"`n" + 'Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }'
	$obj.installScriptMod = $obj.installScriptMod + $exeRemoveString

	download-fileBoth -url32 $url32 -url64 $url64 -filename32 $filename32 -filename64 $filename64 -toolsDir $obj.toolsDir

}


Function mod-anydesk-install ($obj) {

	$url32 = "https://download.anydesk.com/AnyDesk.msi"
	$filename32 = "AnyDesk.msi"

	$filePath32 = '$packageArgs["file"]     = (Join-Path $toolsDir "' + $filename32 + '")'

	$obj.installScriptMod = $obj.installScriptMod -replace " Install-ChocolateyPackage " , " Install-ChocolateyInstallPackage "
	#$obj.installScriptMod = $obj.installScriptMod -replace "(.*)Install-ChocolateyPackage(.*)", "`$1Install-ChocolateyInstallPackage`$2"
	
	
	$obj.installScriptMod = $obj.installScriptMod -replace "Install-ChocolateyInstallPackage" , "$filePath32`n $&"

	download-fileSingle -url $url32 -filename $filename32 -toolsDir $obj.toolsDir
}