FROM ubuntu:16.04

RUN apt-get -y update && \
	apt-get install -y ssh pdsh software-properties-common && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
	apt-get install -y oracle-java8-installer && \
	wget http://apache.crihan.fr/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz && \
	tar -xzf hadoop-3.0.0.tar.gz && \
	rm -rf hadoop-3.0.0.tar.gz && \
	echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /hadoop-3.0.0/etc/hadoop/hadoop-env.sh && \
	echo "export PDSH_RCMD_TYPE=ssh" >> /hadoop-3.0.0/etc/hadoop/hadoop-env.sh && \
	ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
	echo "StrictHostKeyChecking=no" >> ~/.ssh/config && \
	chmod 0600 ~/.ssh/authorized_keys

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

ENV PATH="$PATH:/hadoop-3.0.0/bin"
ENV PATH="$PATH:/hadoop-3.0.0/sbin"

COPY etc/hadoop/core-site.xml /hadoop-3.0.0/etc/hadoop/
COPY etc/hadoop/hdfs-site.xml /hadoop-3.0.0/etc/hadoop/
COPY scripts/bootstrap.sh /

EXPOSE 9870
EXPOSE 8088

VOLUME /jobs
WORKDIR /jobs

CMD /bootstrap.sh
