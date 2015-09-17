FROM oracle-11g-ee:created
MAINTAINER moremagic <itoumagic@gmail.com>

RUN yum -y update
RUN yum install -y passwd openssh-server openssh-clients initscripts

RUN echo 'root:root' | chpasswd
RUN /usr/sbin/sshd-keygen

RUN rm /tmp/create.sh

# Exposes the default TNS port, as well as the Enterprise Manager Express HTTP
# (8080) and HTTPS (5500) ports. 
EXPOSE 22 1521 5500 8080

ADD startdb.sql $ORACLE_HOME/config/scripts/startdb.sql
ADD service.sh /etc/service.sh
RUN chmod +x /etc/service.sh
CMD /etc/service.sh

