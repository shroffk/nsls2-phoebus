@echo OFF

REM Move up one directory to top level
cd ..

REM set the top directory
SET TOP=%cd%

REM Create our lib directory
mkdir %TOP%\lib\jvm

REM download jdk 11
if exist %TOP%\lib\jvm\jdk-11.0.2 goto JVMEXISTS
curl https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_windows-x64_bin.zip --output %TOP%\lib\jvm\openjdk-11.0.2_windows-x64_bin.zip
cd %TOP%\lib\jvm
tar -xf openjdk-11.0.2_windows-x64_bin.zip
rm openjdk-11.0.2_windows-x64_bin.zip
:JVMEXISTS

REM download maven
if exist %TOP%\lib\apache-maven-3.6.0 goto MVNEXISTS
curl https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.zip --output %TOP%\lib\apache-maven-3.6.0-bin.zip
cd %TOP%\lib
tar -xf apache-maven-3.6.0-bin.zip
rm apache-maven-3.6.0-bin.zip
:MVNEXISTS

REM install phoebus
if exist %TOP%\lib\phoebus goto PHOEBUSEXISTS
cd %TOP%\lib
git clone https://github.com/shroffk/phoebus.git
:PHOEBUSEXISTS
cd %TOP%\lib\phoebus
git pull

REM set the java and maven env variables

SET JAVA_HOME=%TOP%\lib\jvm\jdk-11.0.2
SET PATH=%JAVA_HOME%\bin;%PATH%

SET MVN_HOME=%TOP%\lib\apache-maven-3.6.0
SET PATH=%MVN_HOME%\bin;%PATH%

REM build phoebus
cd %TOP%\lib\phoebus
mvn clean install --settings=%TOP%\settings.xml -DskipTests=true

REM build nsls2 product
cd %TOP%\products
mvn clean install --settings=%TOP%\settings.xml -DskipTests=true