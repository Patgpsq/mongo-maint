#!/bin/bash

mongosh --tls --host $BIZ_DB_HOST --tlsCAFile=/tmp/rds-combined-ca-bundle.pem --username=$BIZ_DB_USER --password $BIZ_DB_PASSWORD $BIZ_DB_NAME
