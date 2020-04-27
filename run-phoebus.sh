#!/bin/bash

# Phoebus launcher for Linux or Mac OS X
TOP=/opt/css

export JAVA_HOME=$TOP/lib/jvm/jdk-11.0.2
export PATH="$JAVA_HOME/bin:$PATH"

echo $TOP
V="4.6.3-SNAPSHOT"

# figure out the path to the product jar
if [[ -z "${PHOEBUS_JAR}" ]]; then
  PHOEBUS_JAR=${TOP}/nsls2-phoebus/products/nsls2-accl/target/nsls2-accl-product-${V}.jar
fi

# figure out the path to the configuration settings
if [[ -z "${PHOEBUS_CONFIG}" ]]; then
  PHOEBUS_CONFIG=${TOP}/nsls2-phoebus/config/settings.ini
fi

# To get one instance, use server mode
ID=$(id -u)
OPT="-server 4$ID"

JDK_JAVA_OPTIONS=" -DCA_DISABLE_REPEATER=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dnashorn.args=--no-deprecation-warning"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dlogback.configurationFile=/home/train/epics-tools/setup/settings/logback.xml"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dorg.csstudio.javafx.rtplot.update_counter=false"
export JDK_JAVA_OPTIONS

echo $JDK_JAVA_OPTIONS

java -jar $PHOEBUS_JAR -settings $PHOEBUS_CONFIG -logging $TOP/nsls2-phoebus/config/logging.properties $OPT "$@" &
