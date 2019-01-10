#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=POP2_Launcher.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UPX_Parameters=-9 --strip-relocs=0 --compress-exports=0 --compress-icons=0
#AutoIt3Wrapper_Res_Description=Prince of Persia WW Launcher
#AutoIt3Wrapper_Res_Fileversion=1.0.0.47
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.47
#AutoIt3Wrapper_Res_LegalCopyright=2014, SalFisher47
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_SaveSource=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Pragma Compile ****
#pragma compile(AutoItExecuteAllowed, true)
#pragma compile(Compression, 9)
#pragma compile(Compatibility, vista, win7, win8, win81, win10)
#pragma compile(InputBoxRes, true)
#pragma compile(CompanyName, 'SalFisher47')
#pragma compile(FileDescription, 'Prince of Persia WW Launcher')
#pragma compile(FileVersion, 1.0.0.47)
#pragma compile(InternalName, 'Prince of Persia WW Launcher')
#pragma compile(LegalCopyright, '2014, SalFisher47')
#pragma compile(OriginalFilename, POP2_Launcher.exe)
#pragma compile(ProductName, 'Prince of Persia WW Launcher')
#pragma compile(ProductVersion, 1.0.0.47)
#EndRegion ;**** Pragma Compile ****
; === UniCrack Installer.au3 =======================================================================================================
; Title .........: Prince of Persia WW Launcher
; Version .......: 1.0.0.47
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Prince of Persia WW Widescreen Launcher
;				   - based on UniWS
; Author(s) .....: SalFisher47
; Last Compiled .: January 01, 2019
; ==================================================================================================================================
#include <array.au3>
#include <file.au3>

If Not FileExists(@AppDataCommonDir & "\SalFisher47\7za") Then DirCreate(@AppDataCommonDir & "\SalFisher47\7za")
FileInstall("WidescreenLauncher\RequiredSoftware\7za.exe", @AppDataCommonDir & "\SalFisher47\7za\7za.exe", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\7-Zip.chm", @AppDataCommonDir & "\SalFisher47\7za\7-Zip.chm", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\License.txt", @AppDataCommonDir & "\SalFisher47\7za\License.txt", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\Readme.txt", @AppDataCommonDir & "\SalFisher47\7za\Readme.txt", 0)

If Not FileExists(@AppDataCommonDir & "\SalFisher47\xd3") Then DirCreate(@AppDataCommonDir & "\SalFisher47\xd3")
FileInstall("WidescreenLauncher\RequiredSoftware\xd3.exe", @AppDataCommonDir & "\SalFisher47\xd3\xd3.exe", 0)

If Not FileExists(@AppDataCommonDir & "\SalFisher47\RunFirst") Then DirCreate(@AppDataCommonDir & "\SalFisher47\RunFirst")
FileInstall("RunFirst\RunFirst.exe", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", 0)
FileInstall("RunFirst\RunFirst.txt", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.txt", 0)

If Not StringInStr(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe"), "RUNASADMIN") Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", "REG_SZ", "RUNASADMIN")
EndIf

$exe32bit = @ScriptDir & "\PrinceOfPersia.exe"
If Not StringInStr(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe32bit), "RUNASADMIN") Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe32bit, "REG_SZ", "RUNASADMIN")
EndIf

$widescreen_fix_ini = @ScriptDir & "\POP2_Launcher.ini"
FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
$iniResX = IniRead($widescreen_fix_ini, "MAIN", "X", 0)
$iniResY = IniRead($widescreen_fix_ini, "MAIN", "Y", 0)
If ($iniResX == 0) And ($iniResY == 0) Then
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
ElseIf ($iniResX == 0) Or ($iniResY == 0) Then
	IniWrite($widescreen_fix_ini, "MAIN", "X", " 0")
	IniWrite($widescreen_fix_ini, "MAIN", "Y", " 0")
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
EndIf
$desktopX = $iniResX
$desktopY = $iniResY
$desktopRatio = Round($desktopX/$desktopY, 2)
$supported_res = 0
$HUD_Fix_CanStretchRect = IniRead($widescreen_fix_ini, "GAME", "CanStretchRect", 0)
$Fog_Fix_ForceVSFog = IniRead($widescreen_fix_ini, "GAME", "ForceVSFog", 1)
$Fog_Fix_InvertFogRange = IniRead($widescreen_fix_ini, "GAME", "InvertFogRange", 0)
$RunFirst = IniRead($widescreen_fix_ini, "GAME", "RunFirst", 0)
$patched = IniRead($widescreen_fix_ini, "EXE", "patched", 0)
DirCreate(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher")
FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
$patched_ProgramData = IniRead(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", 0)
If Not FileExists($exe32bit) Then
	MsgBox(16, "Prince of Persia WW Launcher", "Executable not found:" & @CRLF & "..\POP2.exe")
	Exit
EndIf
Local $POP2_4_by_3_array[1], $POP2_4_by_3_txt = @ScriptDir & "\WidescreenLauncher\POP2_1.33 (4 by 3 aspect ratio).txt", $POP2_4_by_3_7z = StringTrimRight($POP2_4_by_3_txt, 4) & ".7z"
Local $POP2_5_by_4_array[1], $POP2_5_by_4_txt = @ScriptDir & "\WidescreenLauncher\POP2_1.25 (5 by 4 aspect ratio).txt", $POP2_5_by_4_7z = StringTrimRight($POP2_5_by_4_txt, 4) & ".7z"
Local $POP2_16_by_9_array[1], $POP2_16_by_9_txt = @ScriptDir & "\WidescreenLauncher\POP2_1.77 (16 by 9 aspect ratio).txt", $POP2_16_by_9_7z = StringTrimRight($POP2_16_by_9_txt, 4) & ".7z"
Local $POP2_16_by_10_array[1], $POP2_16_by_10_txt = @ScriptDir & "\WidescreenLauncher\POP2_1.60 (16 by 10 aspect ratio).txt", $POP2_16_by_10_7z = StringTrimRight($POP2_16_by_10_txt, 4) & ".7z"
Local $POP2_Backup = @ScriptDir & "\WidescreenLauncher\POP2_Backup.7z"
;Local $POP2_Blank = @ScriptDir & "\WidescreenLauncher\POP2_Blank.7z"
Switch $desktopRatio
	Case 1.33   ; 4:3 aspect ratio, 1024x768
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$hFile = FileOpen($POP2_4_by_3_txt)
		For $i = 1 to _FileCountLines($POP2_4_by_3_txt)
			_ArrayAdd($POP2_4_by_3_array, FileReadLine($hFile, $i))
		Next
		FileClose($hFile)

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				For $j = 1 To UBound($POP2_4_by_3_array)-1
					$POP2_4_by_3_name = $POP2_4_by_3_array[$j]
					If $POP2_4_by_3_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
						$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_4_by_3_7z & '"' & ' ' & '"' & $POP2_4_by_3_name & '.xd3' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.exe' & '"'
						RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
						FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.exe', @ScriptDir & '\POP2.exe', 1)
						DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
						$supported_res = 1
						ExitLoop
					EndIf
				Next
				If $supported_res == 1 Then
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				Else
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				EndIf
			EndIf
		Else
			For $j = 1 To UBound($POP2_4_by_3_array)-1
				$POP2_4_by_3_name = $POP2_4_by_3_array[$j]
				If $POP2_4_by_3_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_4_by_3_7z & '"' & ' ' & '"' & $POP2_4_by_3_name & '.xd3' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.exe' & '"'
					RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
					FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_4_by_3_name & '.exe', @ScriptDir & '\POP2.exe', 1)
					DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
					$supported_res = 1
					ExitLoop
				EndIf
			Next
			If $supported_res == 1 Then
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		EndIf

	Case 1.25   ; 5:4 aspect ratio, 1280x1024
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$hFile = FileOpen($POP2_5_by_4_txt)
		For $i = 1 to _FileCountLines($POP2_5_by_4_txt)
			_ArrayAdd($POP2_5_by_4_array, FileReadLine($hFile, $i))
		Next
		FileClose($hFile)

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				For $j = 1 To UBound($POP2_5_by_4_array)-1
					$POP2_5_by_4_name = $POP2_5_by_4_array[$j]
					If $POP2_5_by_4_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
						$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_5_by_4_7z & '"' & ' ' & '"' & $POP2_5_by_4_name & '.xd3' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.exe' & '"'
						RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
						FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.exe', @ScriptDir & '\POP2.exe', 1)
						DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
						$supported_res = 1
						ExitLoop
					EndIf
				Next
				If $supported_res == 1 Then
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				Else
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				EndIf
			EndIf
		Else
			For $j = 1 To UBound($POP2_5_by_4_array)-1
				$POP2_5_by_4_name = $POP2_5_by_4_array[$j]
				If $POP2_5_by_4_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_5_by_4_7z & '"' & ' ' & '"' & $POP2_5_by_4_name & '.xd3' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.exe' & '"'
					RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
					FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_5_by_4_name & '.exe', @ScriptDir & '\POP2.exe', 1)
					DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
					$supported_res = 1
					ExitLoop
				EndIf
			Next
			If $supported_res == 1 Then
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		EndIf

	Case 1.77   ; 16:9 aspect ratio, 1360x768
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$hFile = FileOpen($POP2_16_by_9_txt)
		For $i = 1 to _FileCountLines($POP2_16_by_9_txt)
			_ArrayAdd($POP2_16_by_9_array, FileReadLine($hFile, $i))
		Next
		FileClose($hFile)

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				For $j = 1 To UBound($POP2_16_by_9_array)-1
					$POP2_16_by_9_name = $POP2_16_by_9_array[$j]
					If $POP2_16_by_9_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
						$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_9_7z & '"' & ' ' & '"' & $POP2_16_by_9_name & '.xd3' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe' & '"'
						RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
						FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe', @ScriptDir & '\POP2.exe', 1)
						DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
						$supported_res = 1
						ExitLoop
					EndIf
				Next
				If $supported_res == 1 Then
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				Else
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				EndIf
			EndIf
		Else
			For $j = 1 To UBound($POP2_16_by_9_array)-1
				$POP2_16_by_9_name = $POP2_16_by_9_array[$j]
				If $POP2_16_by_9_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_9_7z & '"' & ' ' & '"' & $POP2_16_by_9_name & '.xd3' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe' & '"'
					RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
					FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe', @ScriptDir & '\POP2.exe', 1)
					DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
					$supported_res = 1
					ExitLoop
				EndIf
			Next
			If $supported_res == 1 Then
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		EndIf

	Case 1.78   ; 16:9 aspect ratio, 1366x768
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$hFile = FileOpen($POP2_16_by_9_txt)
		For $i = 1 to _FileCountLines($POP2_16_by_9_txt)
			_ArrayAdd($POP2_16_by_9_array, FileReadLine($hFile, $i))
		Next
		FileClose($hFile)

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				For $j = 1 To UBound($POP2_16_by_9_array)-1
					$POP2_16_by_9_name = $POP2_16_by_9_array[$j]
					If $POP2_16_by_9_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
						$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_9_7z & '"' & ' ' & '"' & $POP2_16_by_9_name & '.xd3' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe' & '"'
						RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
						FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe', @ScriptDir & '\POP2.exe', 1)
						DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
						$supported_res = 1
						ExitLoop
					EndIf
				Next
				If $supported_res == 1 Then
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				Else
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				EndIf
			EndIf
		Else
			For $j = 1 To UBound($POP2_16_by_9_array)-1
				$POP2_16_by_9_name = $POP2_16_by_9_array[$j]
				If $POP2_16_by_9_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_9_7z & '"' & ' ' & '"' & $POP2_16_by_9_name & '.xd3' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe' & '"'
					RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
					FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_9_name & '.exe', @ScriptDir & '\POP2.exe', 1)
					DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
					$supported_res = 1
					ExitLoop
				EndIf
			Next
			If $supported_res == 1 Then
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		EndIf

	Case 1.60   ; 16:10 aspect ratio, 1440x900
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$hFile = FileOpen($POP2_16_by_10_txt)
		For $i = 1 to _FileCountLines($POP2_16_by_10_txt)
			_ArrayAdd($POP2_16_by_10_array, FileReadLine($hFile, $i))
		Next
		FileClose($hFile)

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				For $j = 1 To UBound($POP2_16_by_10_array)-1
					$POP2_16_by_10_name = $POP2_16_by_10_array[$j]
					If $POP2_16_by_10_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
						$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_10_7z & '"' & ' ' & '"' & $POP2_16_by_10_name & '.xd3' & '"'
						ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
						$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.exe' & '"'
						RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
						FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.exe', @ScriptDir & '\POP2.exe', 1)
						DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
						$supported_res = 1
						ExitLoop
					EndIf
				Next
				If $supported_res == 1 Then
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				Else
					IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
					IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
					FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
					ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
					If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
					FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
					If $RunFirst == 1 Then
						ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
					Else
						ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
					EndIf
				EndIf
			EndIf
		Else
			For $j = 1 To UBound($POP2_16_by_10_array)-1
				$POP2_16_by_10_name = $POP2_16_by_10_array[$j]
				If $POP2_16_by_10_name == "POP2 ~ " & $desktopX & "x" & $desktopY Then
					$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP2_WidescreenLauncher' & '"' & ' ' & '"' & $POP2_16_by_10_7z & '"' & ' ' & '"' & $POP2_16_by_10_name & '.xd3' & '"'
					ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
					$xdelta_patch_line_pop = ' -d -s ' & '"' & @ScriptDir & '\POP2.exe' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.xd3' & '"' & ' ' & '"' & @TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.exe' & '"'
					RunWait(@AppDataCommonDir & "\SalFisher47\xd3\xd3.exe" & $xdelta_patch_line_pop, @AppDataCommonDir & "\SalFisher47\xd3", @SW_HIDE)
					FileCopy(@TempDir & '\POP2_WidescreenLauncher\' & $POP2_16_by_10_name & '.exe', @ScriptDir & '\POP2.exe', 1)
					DirRemove(@TempDir & '\POP2_WidescreenLauncher', 1)
					$supported_res = 1
					ExitLoop
				EndIf
			Next
			If $supported_res == 1 Then
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		EndIf

	Case Else   ; other aspect ratio
		FileInstall("POP2_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP2_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		If $patched_ProgramData == 1 Then
			$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		Else
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP2.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			$7z_unpack_line = ' x -y -o' & '"' & @ScriptDir & '"' & ' ' & '"' & $POP2_Backup & '"' & ' ' & '"' & '*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP2.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

EndSwitch
