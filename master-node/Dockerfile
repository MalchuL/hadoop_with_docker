FROM master_node



RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

#This operation has no effect
#COPY hosts /etc/hosts
#GENERATE SSH KEY
RUN yes "" | ssh-keygen -t rsa -P ""
#COPY KEY
RUN cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

#RUN echo "192.168.0.1    master " >> /etc/hosts

#RUN echo "echo \"192.168.0.1    master \" >> /etc/hosts" >> /etc/bashrc

ENV HADOOP_INSTALL=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_INSTALL/bin
ENV PATH=$PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_INSTALL
ENV HADOOP_COMMON_HOME=$HADOOP_INSTALL
ENV HADOOP_HDFS_HOME=$HADOOP_INSTALL
ENV YARN_HOME=$HADOOP_INSTALL

COPY hadoop_config/* /usr/local/hadoop/etc/hadoop/

WORKDIR /usr/local/hadoop/

COPY run.sh run.sh
RUN chmod 777 run.sh

COPY sshd_config /etc/ssh/sshd_config 

RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "    UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

CMD ./run.sh

