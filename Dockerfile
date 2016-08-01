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

EXPOSE 22
EXPOSE 80
EXPOSE 8080

CMD    ["/usr/sbin/sshd", "-D"]
