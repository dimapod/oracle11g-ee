#!/bin/bash

cat >> /home/oracle/.bash_profile <<EOF
ORACLE_BASE=/u01/app/oracle
export ORACLE_BASE
ORACLE_SID=ORCL
export ORACLE_SID
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$PATH
export PATH
EOF

mount -t tmpfs shmfs -o size=4g /dev/shm

date
echo "Creating database..."
su -s /bin/bash oracle -c "sqlplus /nolog @?/config/scripts/createdb.sql"
echo ""

date
echo "Creating password file..."
cd $ORACLE_HOME/dbs
su -s /bin/bash oracle -c "$ORACLE_HOME/bin/orapwd FILE=orapw$ORACLE_SID password=change_on_install"
echo ""

date
echo "Running catalog.sql..."
cd $ORACLE_HOME/rdbms/admin
cp catalog.sql catalog-e.sql
echo "exit" >> catalog-e.sql
su -s /bin/bash oracle -c "sqlplus / as sysdba @?/rdbms/admin/catalog-e.sql > /tmp/catalog.log"
rm catalog-e.sql
echo ""

date
echo "Running catproc.sql..."
cd $ORACLE_HOME/rdbms/admin
cp catproc.sql catproc-e.sql
echo "exit" >> catproc-e.sql
su -s /bin/bash oracle -c "sqlplus / as sysdba @?/rdbms/admin/catproc-e.sql > /tmp/catproc.log"
rm catproc-e.sql
echo ""

date
echo "Running pupbld.sql..."
cd $ORACLE_HOME/sqlplus/admin
cp pupbld.sql pupbld-e.sql
echo "exit" >> pupbld-e.sql
su -s /bin/bash oracle -c "sqlplus system/manager @?/sqlplus/admin/pupbld-e.sql > /tmp/pupbld.log"
rm pupbld-e.sql
echo ""

echo "Finalizing install and shutting down the database..."
su -s /bin/bash oracle -c "sqlplus / as sysdba @?/config/scripts/conf_finish.sql"
echo ""

date
echo "Create is done; commit the container now"

