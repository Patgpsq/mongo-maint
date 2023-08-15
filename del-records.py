import pymongo
import os
import sys
from bson import BSON


# these no longer exist, just examples
del_list = [
  "f47217e0-d6c6-11ed-b75c-3346c9dcd5de",
  "6479c69b6e661c00121fe5db",
  "8405e430-1782-11ee-82d0-dbb190631219",
  # ...
  "30fc2680-3058-11ed-97ce-19bed5315b3d",
  "8827ba15-8d3f-11ed-80bd-50eb7179fd78",
  "6daf2ba0-265b-11ee-9804-c37c15086ef4",
  "02297dc0-c9c4-11ed-931e-85fd1c9d4e1"
  ]
BIZ_DB_NAME=os.getenv('BIZ_DB_NAME')
BIZ_DB_HOST=os.getenv('BIZ_DB_HOST')
BIZ_DB_USER=os.getenv('BIZ_DB_USER')
BIZ_DB_PASSWORD=os.getenv('BIZ_DB_PASSWORD')
BIZ_DB_PORT=os.getenv('BIZ_DB_PORT')

# MongoDB client, open a connection to Amazon DocumentDB
# as a replica set and specify the read preference as secondary preferred
client = pymongo.MongoClient('mongodb://' + BIZ_DB_USER + ':' + BIZ_DB_PASSWORD + '@' + BIZ_DB_HOST + ':' + BIZ_DB_PORT + '/?tls=true&tlsCAFile=/tmp/rds-combined-ca-bundle.pem')

# Specify the database to be used
db = client.bizDB

col_names = db.list_collection_names()
# sanity check if you want
# print(col_names)

del_list_bson = BSON.encode(del_list)
deleted = db.business.delete_many('businessID',{ '$in': del_list_bson})

print("deleted: " + deleted + "\n");
# Specify the collection to be used
# col = db.sample_collection

## Another example
# for q_item in del_list: 
#    rec = db.products.find_one(q_item)
#    print(rec)

# Close the connection
client.close()
