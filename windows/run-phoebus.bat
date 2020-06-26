@echo OFF

cd ..

SET TOP=%cd%

SET JAVA_HOME=%TOP%\lib\jvm\jdk-11.0.2
SET PATH=%JAVA_HOME%\bin;%PATH%

echo %TOP%
SET PHOEBUS_VERSION="4.6.2-SNAPSHOT"

REM figure out the path to the product jar
PHOEBUS_JAR=%TOP%\products\nsls2-accl\target\nsls2-accl-product-%PHOEBUS_VERSION%.jar


SET JDK_JAVA_OPTIONS=" -DCA_DISABLE_REPEATER=true"
SET JDK_JAVA_OPTIONS="%JDK_JAVA_OPTIONS% -Dnashorn.args=--no-deprecation-warning"
SET JDK_JAVA_OPTIONS="%JDK_JAVA_OPTIONS% -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true"
REM SET JDK_JAVA_OPTIONS="%JDK_JAVA_OPTIONS% -Dlogback.configurationFile=\home\train\epics-tools\setup\settings\logback.xml"
SET JDK_JAVA_OPTIONS="%JDK_JAVA_OPTIONS% -Dorg.csstudio.javafx.rtplot.update_counter=false"

echo %JDK_JAVA_OPTIONS%

java -jar %PHOEBUS_JAR% -settings %PHOEBUS_CONFIG% -logging %TOP%\config\logging.properties $OPT "$@" &