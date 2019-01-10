### Prince of Persia: Warrior Within ~ Widescreen Launcher

Old launcher based on the *UniWS patching method* at [http://www.wsgf.org](http://www.wsgf.org/article/universal-widescreen-uniws-patcher) and *RELOADED's crack*; you should use the new [Widescreen Launcher v2](https://github.com/alex47exe/Prince-of-Persia-WW_WidescreenLauncher_v2/releases)!

------

***Features:***

- includes *[7za.exe](https://www.7-zip.org/download.html)*, *[RunFirst.exe](https://www.activeplus.com/products/runfirst)* & [xd3.exe](http://xdelta.org/), which are unpacked at first launch in *C:\Program Data\SalFisher47*
- automatically detects resolution and aspect ratio, then unpacks *POP2.exe* from *WidescreenLauncher\POP2_Backup.7z* and patches it with the correct *xd3* file for the needed resolution
- *RELOADED's crack* was used as a base for creating the executables for various aspect ratios and resolutions, then I used *POP2_Create_Xdelta.au3* to generate the *xd3* files
- when *POP2.exe* runs the first time, *Hardware.ini* gets reset to some default values, causing some graphical issues when fog is enabled; to avoid this, launcher uses *Blank.exe* instead of *POP2.exe* at first run, corrects those values, then launches the game
- game will run on the first cpu core, to avoid extreme gameplay speed on multi-core cpus

------

***Requirements:***

1. Prince of Persia: Warrior Within

------

