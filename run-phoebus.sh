#!/bin/sh

# Phoebus launcher for Linux or Mac OS X
TOP="$PWD"

export JAVA_HOME=$TOP/lib/jvm/jdk-11.0.2
export PATH="$JAVA_HOME/bin:$PATH"

echo $TOP
V="0.0.1"

# Use ant or maven jar?
if [ -f ${TOP}/target/nsls2-product-${V}.jar ]
then
  JAR="${TOP}/target/nsls2-product-${V}.jar"
else
  JAR="${TOP}/target/nsls2-product-${V}-SNAPSHOT.jar"
fi

# To get one instance, use server mode
ID=$(id -u)
echo $ID
OPT="-server 4$ID"
echo $OPT

JDK_JAVA_OPTIONS=" -DCA_DISABLE_REPEATER=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dnashorn.args=--no-deprecation-warning"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dlogback.configurationFile=/home/train/epics-tools/setup/settings/logback.xml"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dorg.csstudio.javafx.rtplot.update_counter=false"
export JDK_JAVA_OPTIONS

echo $JDK_JAVA_OPTIONS

java -jar $JAR -settings $TOP/config/settings.ini $OPT "$@" &
