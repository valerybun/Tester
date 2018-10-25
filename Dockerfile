
FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Install JDK

RUN Invoke-WebRequest 'http://www.dropbox.com/s/arjdndbywglhwkt/jdk-8u151-windows-x64.exe?dl=1&m=' -OutFile jdk-8u151-windows-x64.exe -UseBasicParsing 
RUN Start-Process -FilePath C:\jdk-8u151-windows-x64.exe -PassThru -Wait -ArgumentList "/s,INSTALLDIR=c:\Java\jdk1.8.0_151,/L,install64.log"
RUN $JavaHomePath = $('C:\Java\jdk1.8.0_151') ; [Environment]::SetEnvironmentVariable('JAVA_HOME', $JavaHomePath, 'Machine')
RUN $JavaPath = $($Env:PATH + ';' + 'C:\Java\jdk1.8.0_151\bin') ; [Environment]::SetEnvironmentVariable('PATH', $JavaPath, 'Machine')
RUN del C:\jdk-8u151-windows-x64.exe

#Install Git 2.15.0

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install git.install -y


#INSTALL VS2015 Build tools with c++ build support

ADD "http://go.microsoft.com/fwlink/?LinkId=691126&__hstc=268264337.d8c9bb367c4a4aeea40b2e4d833f5b7b.1509631607874.1509791654032.1509793951124.4&__hssc=268264337.1.1509793951124&__hsfp=3384890572&fixForIE=.exe" vscppbuildtools.exe
RUN Start-Process -FilePath '.\vscppbuildtools.exe' -ArgumentList '/Quiet', '/NoRestart' -Wait
RUN $MSBuildPath = $($Env:PATH + ';' + ${Env:ProgramFiles(x86)} + '\MSBuild\14.0\Bin') ; [Environment]::SetEnvironmentVariable('PATH', $MSBuildPath, 'Machine')
RUN del C:\vscppbuildtools.exe

#INSTALL VSTEST2015 and MSTEST

ADD "https://download.microsoft.com/download/6/0/e/60e06c19-2bfd-40da-8af8-4cd7b897a336/vstf_testagent.exe" vstest.exe
RUN Start-Process -FilePath '.\vstest.exe' -ArgumentList '/Full', '/NoRestart', '/Q' -Wait
RUN $VSTestPath =  $($Env:PATH + ';' + ${Env:ProgramFiles(x86)} + '\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow') ; [Environment]::SetEnvironmentVariable('PATH', $VSTestPath, 'Machine')
RUN $MSTestPath =  $($Env:PATH + ';' + ${Env:ProgramFiles(x86)} + '\Microsoft Visual Studio 14.0\Common7\IDE') ; [Environment]::SetEnvironmentVariable('PATH', $MSTestPath, 'Machine')
RUN del C:\vstest.exe

#Install bamboo service
ADD "http://codedev2.waters.com/bamboo/agentServer/agentInstaller" atlassian-bamboo-agent-installer-6.1.1.jar
RUN java -jar atlassian-bamboo-agent-installer-6.1.1.jar http://codedev2.waters.com/bamboo/agentServer/ installntservice