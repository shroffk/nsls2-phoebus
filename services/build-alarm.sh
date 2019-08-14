#!/bin/sh

# should point to the nsls2-phoebus installation location
export TOP="$PWD"

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
    mv kibana-6.3.1-linux-x86_64 kibana-6.3.1
    rm /tmp/kibana-6.3.1-linux-x86_64.tar.gz
fi

# download kafka
if [ ! -d ${TOP}/lib/kafka_2.11-2.1.0 ]; then
    wget --no-check-certificate https://archive.apache.org/dist/kafka/2.1.0/kafka_2.11-2.1.0.tgz -O /tmp/kafka_2.11-2.1.0.tgz
    tar xzvf /tmp/kafka_2.11-2.1.0.tgz --directory ${TOP}/lib
    rm /tmp/kafka_2.11-2.1.0.tgz
fi

