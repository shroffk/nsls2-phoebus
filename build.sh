#!/bin/sh

# Build phoebus and nsls2 product

export TOP="$PWD"

# Download third party tools and services needed for the epics tools and services
mkdir -p ${TOP}/lib/jvm

# download jdk 11
if [ ! -d ${TOP}/lib/jvm/jdk-11.0.2 ]; then
    wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz -O /tmp/openjdk-11+28_linux-x64_bin.tar.gz
    tar xfvz /tmp/openjdk-11+28_linux-x64_bin.tar.gz --directory ${TOP}/lib/jvm
    rm /tmp/openjdk-11+28_linux-x64_bin.tar.gz
fi


# download maven
if [ ! -d ${TOP}/lib/apache-maven-3.6.0 ]; then
    wget https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -O /tmp/apache-maven-3.6.0-bin.tar.gz
    tar xzvf /tmp/apache-maven-3.6.0-bin.tar.gz --directory ${TOP}/lib
    rm /tmp/apache-maven-3.6.0-bin.tar.gz
fi


# install phoebus
if [ ! -d ${TOP}/lib/phoebus ]; then
    cd ${TOP}/lib
    git clone https://github.com/shroffk/phoebus.git
fi
cd ${TOP}/lib/phoebus
git pull

# set the java and maven env variables

export JAVA_HOME=$TOP/lib/jvm/jdk-11.0.2
export PATH="$JAVA_HOME/bin:$PATH"

export MVN_HOME=$TOP/lib/apache-maven-3.6.0
export PATH="$MVN_HOME/bin:$PATH"

#build phoebus
cd $TOP/lib/phoebus
mvn clean install --settings=$TOP/settings.xml -DskipTests=true

#build nsls2 product
cd $TOP/products
mvn clean install --settings=$TOP/settings.xml -DskipTests=true


