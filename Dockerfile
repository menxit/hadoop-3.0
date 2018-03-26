FROM openjdk:8-jre

ADD http://apache.panu.it/hadoop/common/hadoop-3.0.1/hadoop-3.0.1.tar.gz /

RUN apt-get -y update && \
	apt-get install -y ssh pdsh software-properties-common && \
	apt-get update && \
	tar -xzf hadoop-3.0.1.tar.gz && \
	rm -rf hadoop-3.0.1.tar.gz && \
	echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /hadoop-3.0.1/etc/hadoop/hadoop-env.sh && \
	echo "export PDSH_RCMD_TYPE=ssh" >> /hadoop-3.0.1/etc/hadoop/hadoop-env.sh && \
	ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
	echo "StrictHostKeyChecking=no" >> ~/.ssh/config && \
	chmod 0600 ~/.ssh/authorized_keys

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

ENV PATH="$PATH:/hadoop-3.0.1/bin"
ENV PATH="$PATH:/hadoop-3.0.1/sbin"

COPY etc/hadoop/core-site.xml /hadoop-3.0.1/etc/hadoop/
COPY etc/hadoop/hdfs-site.xml /hadoop-3.0.1/etc/hadoop/
COPY scripts/bootstrap.sh /

EXPOSE 9870
EXPOSE 8088

VOLUME /jobs
WORKDIR /jobs

CMD /bootstrap.sh
