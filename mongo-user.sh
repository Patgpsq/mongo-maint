#!/bin/bash

mongosh --tls --host $DB_HOST --tlsCAFile=/tmp/rds-combined-ca-bundle.pem --username=$DB_USER --password $DB_PASSWORD 
