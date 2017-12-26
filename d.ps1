#$url_vs17 = 'http://tu-server-slv01.corp.waters.com/artifactory/UNIFI-Misc/CITools/VisualStudio/2017/vs_Enterprise.exe'
#$url_jdk = 'http://tu-server-slv01.corp.waters.com/artifactory/UNIFI-Misc/CITools/jdk-8u151-windows-x64.exe'
#$url_bamboo = 'http://codedev2.waters.com/bamboo/agentServer/agentInstaller'
$url_git = "https://github.com/git-for-windows/git/releases/download/v2.15.1.windows.2/Git-2.15.1.2-64-bit.exe"
#$JavaHomePath = $('C:\Java\jdk1.8.0_151')
#$JavaPath = $($Env:PATH + ';' + 'C:\Java\jdk1.8.0_151\bin')
#$GitPath = $($Env:PATH + ';' + 'C:\Program Files\Git\bin')

#Invoke-WebRequest -Uri $url_vs17 -OutFile vs_2017.exe 
#Invoke-WebRequest -Uri $url_jdk -OutFile jdk-8u151-windows-x64.exe
#Invoke-WebRequest -Uri $url_bamboo -OutFile atlassian-bamboo-agent-installer-6.1.1.jar
Invoke-WebRequest -Uri $url_git -OutFile gitinstall.exe

#Start-Process -FilePath C:\jdk-8u151-windows-x64.exe -PassThru -Wait -ArgumentList "/s,INSTALLDIR=c:\Java\jdk1.8.0_151,/L,install64.log"
#Start-Process .\gitinstall.exe -Wait '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /LOG' 

#New-Item -Path 'hklm:\SOFTWARE\Wow6432Node\Microsoft\StrongName\Verification\*,a19f4630a032484b' -ItemType Key -Force 
#New-Item -Path 'hklm:\SOFTWARE\Microsoft\StrongName\Verification\*,a19f4630a032484b' -ItemType Key -Force
