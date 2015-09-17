FROM oracle/oraclelinux
MAINTAINER moremagic <itoumagic@gmail.com>

######################
ADD /resource/linux.x64_11gR2_database_1of2.zip /tmp/install/linux.x64_11gR2_database_1of2.zip
ADD /resource/linux.x64_11gR2_database_2of2.zip /tmp/install/linux.x64_11gR2_database_2of2.zip
RUN yum -y install unzip binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33.i686 gcc gcc-c++ glibc.i686 glibc glibc-devel glibc-devel.i686 ksh libgcc.i686 libgcc libstdc++ libstdc++.i686 libstdc++-devel libstdc++-devel.i686 libaio libaio.i686 libaio-devel libaio-devel.i686 libXext libXext.i686 libXtst libXtst.i686 libX11 libX11.i686 libXau libXau.i686 libxcb libxcb.i686 libXi libXi.i686 make sysstat vte3 smartmontools
RUN cd /tmp/install && unzip linux.x64_11gR2_database_1of2.zip && unzip linux.x64_11gR2_database_2of2.zip && rm *.zip

RUN groupadd -g 54321 oinstall && groupadd -g 54322 dba
# RUN userdel oracle && rm -rf /home/oracle && rm /var/spool/mail/oracle
RUN useradd -m -u 54321 -g oinstall -G dba oracle
RUN echo "oracle:oracle" | chpasswd

ENV ORACLE_BASE /home/oracle/app/oracle

RUN mkdir -p $ORACLE_BASE && chown -R oracle:oinstall $ORACLE_BASE && chmod -R 775 $ORACLE_BASE
RUN mkdir -p /opt/app/oraInventory && chown -R oracle:oinstall /opt/app/oraInventory && chmod -R 775 /opt/app/oraInventory
ADD /resource/oraInst.loc /etc/oraInst.loc
RUN chmod 664 /etc/oraInst.loc

ADD /resource/sysctl.conf /etc/sysctl.conf
RUN echo "oracle soft stack 10240" >> /etc/security/limits.conf

# ENV CVUQDISK_GRP oinstall
# RUN cd /tmp/install/database/rpm && rpm -iv cvuqdisk-1.0.9-1.rpm

ADD /resource/db_install.rsp /tmp/db_install.rsp
ADD /resource/install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh

