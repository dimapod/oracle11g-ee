#! /bin/bash

# step1
docker build -t oracle-step1 step1
docker run --privileged -ti --name step1 oracle-step1 /tmp/install.sh
docker commit step1 oracle-11g-ee:installed

# step2
docker build -t oracle-step2 step2
docker run  --privileged -ti --name step2 oracle-step2 /tmp/create.sh
docker commit step2 oracle-11g-ee:created

# step3
docker build -t oracle-11g-ee step3
