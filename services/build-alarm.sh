#!/bin/sh

# should point to the nsls2-phoebus installation location
export TOP=/opt/css

# Download third party tools and services needed for the epics tools and services
mkdir -p ${TOP}/lib/jvm

# download jdk 11
if [ ! -d ${TOP}/lib/jvm/jdk-11.0.2 ]; then
    wget --no-verbose https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz -O /tmp/openjdk-11+28_linux-x64_bin.tar.gz
    tar xfvz /tmp/openjdk-11+28_linux-x64_bin.tar.gz --directory ${TOP}/lib/jvm
    rm /tmp/openjdk-11+28_linux-x64_bin.tar.gz
fi

# download maven
if [ ! -d ${TOP}/lib/apache-maven-3.6.0 ]; then
    wget --no-verbose https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -O /tmp/apache-maven-3.6.0-bin.tar.gz
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
mvn clean install --settings=$TOP/nsls2-phoebus/settings.xml -DskipTests=true

# download elastic
if [ ! -d ${TOP}/lib/elasticsearch-6.3.1 ]; then
    wget --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.1.tar.gz -O /tmp/elasticsearch-6.3.1.tar.gz
    tar xzvf /tmp/elasticsearch-6.3.1.tar.gz --directory ${TOP}/lib
    rm /tmp/elasticsearch-6.3.1.tar.gz
fi

# download kibana
if [ ! -d ${TOP}/lib/kibana-6.3.1 ]; then
    wget --no-check-certificate https://artifacts.elastic.co/downloads/kibana/kibana-6.3.1-linux-x86_64.tar.gz -O /tmp/kibana-6.3.1-linux-x86_64.tar.gz
    tar xzvf /tmp/kibana-6.3.1-linux-x86_64.tar.gz --directory ${TOP}/lib
    mv ${TOP}/lib/kibana-6.3.1-linux-x86_64 ${TOP}/lib/kibana-6.3.1
    rm /tmp/kibana-6.3.1-linux-x86_64.tar.gz
fi

# download kafka
if [ ! -d ${TOP}/lib/kafka_2.11-2.1.0 ]; then
    wget --no-check-certificate https://archive.apache.org/dist/kafka/2.1.0/kafka_2.11-2.1.0.tgz -O /tmp/kafka_2.11-2.1.0.tgz
    tar xzvf /tmp/kafka_2.11-2.1.0.tgz --directory ${TOP}/lib
    rm /tmp/kafka_2.11-2.1.0.tgz
fi

# fix the data location for the kafka server
sed -i 's/\/tmp\/kafka-logs/\/opt\/css\/data\/kafka-logs/' ${TOP}/lib/kafka_2.11-2.1.0/config/server.properties

