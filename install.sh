#!/bin/bash

ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime 
export DEBIAN_FRONTEND=noninteractive
apt update -y 
apt install -y curl gnupg wget vim jq ca-certificates python3 
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
apt update -y
apt install -y mongodb-org=6.0.8 mongodb-org-database=6.0.8 mongodb-org-server=6.0.8 mongodb-org-mongos=6.0.8 mongodb-org-tools=6.0.8
update-ca-certificates --fresh && mkdir -pv /tmp/aws-ca && curl -ksL 'https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem' -o /tmp/aws-ca/aws-global-bundle.pem && cd /tmp/aws-ca && csplit -sz aws-global-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}' && for CERT in /tmp/aws-ca/xx*; do mv $CERT /usr/local/share/ca-certificates/aws-global-ca-$(basename $CERT).crt; done && rm -rfv /tmp/aws-ca && update-ca-certificates
apt install -y python3-pymongo
