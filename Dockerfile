FROM ubuntu:16.04

ADD http://apache.crihan.fr/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz .

RUN apt-get update && \
	apt-get install -y ssh pdsh software-properties-common && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
	apt-get install -y oracle-java8-installer && \
	tar -xzf hadoop-3.0.0.tar.gz && \
	rm -rf hadoop-3.0.0.tar.gz && \
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre/bin/java && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> hadoop-env.sh && \
    export PATH=$PATH:/hadoop-3.0.0/bin

WORKDIR hadoop-3.0.0

COPY etc/hadoop/core-site.xml etc/hadoop/
COPY etc/hadoop/hdfs-site.xml etc/hadoop/

