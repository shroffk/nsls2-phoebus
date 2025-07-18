@echo OFF

REM Move up one directory to top level
cd ..

REM set the top directory
SET TOP=%cd%

REM Create our lib directory
mkdir %TOP%\lib\jvm

REM download jdk 17
if exist %TOP%\lib\jvm\jdk-17.0.10+7 goto JVMEXISTS
curl https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip --output %TOP%\lib\jvm\OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip
cd %TOP%\lib\jvm
tar -xf OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip
rm OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip
:JVMEXISTS

REM download maven
if exist %TOP%\lib\apache-maven-3.9.9 goto MVNEXISTS
curl https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip --output %TOP%\lib\apache-maven-3.9.9-bin.zip
cd %TOP%\lib
tar -xf apache-maven-3.9.9-bin.zip
rm apache-maven-3.9.9-bin.zip
:MVNEXISTS

REM install phoebus
if exist %TOP%\lib\phoebus goto PHOEBUSEXISTS
cd %TOP%\libhttps://github.com/ControlSystemStudio/phoebus
:PHOEBUSEXISTS
cd %TOP%\lib\phoebus
git pull

REM set the java and maven env variables

SET JAVA_HOME=%TOP%\lib\jvm\jdk-17.0.10+7
SET PATH=%JAVA_HOME%\bin;%PATH%

SET MVN_HOME=%TOP%\lib\apache-maven-3.9.9
SET PATH=%MVN_HOME%\bin;%PATH%

REM build phoebus
cd %TOP%\lib\phoebus
mvn clean install --settings=%TOP%\settings.xml -DskipTests=true

REM build nsls2 product
cd %TOP%\products
mvn clean install --settings=%TOP%\settings.xml -DskipTests=true