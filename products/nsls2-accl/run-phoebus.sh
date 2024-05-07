#!/bin/bash

# Phoebus launcher for Linux or Mac OS X
# When deploying, change "TOP"
# to the absolute installation path
# TOP="."
TOP="$( cd "$(dirname "$0")" ; pwd -P )"

#export JAVA_HOME=${TOP}/lib/jvm/jdk-17
#export PATH="$JAVA_HOME/bin:$PATH"

echo $TOP
V="4.7.4-SNAPSHOT"

# figure out the path to the product jar
if [[ -z "${PHOEBUS_JAR}" ]]; then
  PHOEBUS_JAR=${TOP}/products/nsls2-accl/target/nsls2-accl-product-${V}.jar
fi

# figure out the path to the configuration settings
if [[ -z "${PHOEBUS_CONFIG}" ]]; then
  PHOEBUS_CONFIG=${TOP}/config/settings.ini
fi

# To get one instance, use server mode
if [ "$STANDALONE" = "no" ]; then
  ID=$(id -u)
  if [[ $ID -ge 10000 ]]
  then
    OPT="-server ${ID:0:5}"
  else
    OPT="-server 4$ID"
  fi
fi

JDK_JAVA_OPTIONS=" -DCA_DISABLE_REPEATER=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dnashorn.args=--no-deprecation-warning"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dlogback.configurationFile=${TOP}/config/logback.xml"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dorg.csstudio.javafx.rtplot.update_counter=false"
export JDK_JAVA_OPTIONS

echo $JDK_JAVA_OPTIONS

java -jar $PHOEBUS_JAR -settings $PHOEBUS_CONFIG -logging ${TOP}/config/logging.properties $OPT "$@" &
