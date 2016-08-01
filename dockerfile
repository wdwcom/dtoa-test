FROM        centos
MAINTAINER  "5288776@qq.com"

RUN yum install -y openssh-server
RUN yum install -y unzip
RUN        ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN        ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key

RUN echo 'root:111111' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir -p /sw
COPY  /sw/jdk-7u45-linux-x64.rpm /sw/
COPY  /sw/tomcat7.zip /sw/
RUN rpm -ivh /sw/jdk-7u45-linux-x64.rpm
RUN unzip /sw/tomcat7.zip
RUN echo 'JAVA_HOME=/usr/java/jdk1.7.0_45' >> /etc/profile
RUN echo 'CLASSPATH=$JAVA_HOME/lib/tools.jar' >> /etc/profile
RUN echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
RUN echo 'export JAVA_HOME CLASSPATH PATH' >> /etc/profile
RUN source /etc/profile

EXPOSE 22
EXPOSE 80
EXPOSE 8080

CMD    ["/usr/sbin/sshd", "-D"]
