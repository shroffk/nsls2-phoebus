#!/bin/sh

# Build Phoebus and nsls2 product

TOP="$( cd "$(dirname "$0")" ; pwd -P )"

# Download third party tools and services needed for the epics tools and services
mkdir -p ${TOP}/lib/jvm

# download jdk 11
if [ ! -d ${TOP}/lib/jvm/jdk-17 ]; then
    wget --no-verbose https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz -O /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz
    tar xfvz /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz --directory ${TOP}/lib/jvm && mv ${TOP}/lib/jvm/jdk-17.0.10+7 ${TOP}/lib/jvm/jdk-17
    rm /tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz
fi


# download maven
if [ ! -d ${TOP}/lib/apache-maven-3.9.9 ]; then
    wget --no-verbose https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz -O /tmp/apache-maven-3.9.9-bin.tar.gz
    tar xzvf /tmp/apache-maven-3.9.9-bin.tar.gz --directory ${TOP}/lib
    rm /tmp/apache-maven-3.9.9-bin.tar.gz
fi


# install phoebus
if [ ! -d ${TOP}/lib/phoebus ]; then
    cd ${TOP}/lib
    git clone https://github.com/ControlSystemStudio/phoebus --branch v5.0.0 --single-branch
fi

# Update the git repos
cd ${TOP}/lib/phoebus
git reset --hard
git pull

# set the java and maven env variables

export JAVA_HOME=${TOP}/lib/jvm/jdk-17
export PATH="${JAVA_HOME}/bin:$PATH"

export MVN_HOME=${TOP}/lib/apache-maven-3.9.9
export PATH="${MVN_HOME}/bin:$PATH"

# Build phoebus
cd ${TOP}/lib/phoebus

# Build the documentation and help
mvn clean verify -P sphinx -N
# Build the common phoebus binaries
mvn clean install -DskipTests=true

# Build nsls2 product products
cd $TOP/products
mvn clean install -DskipTests=true -Ddocs=${TOP}/lib/phoebus/docs

