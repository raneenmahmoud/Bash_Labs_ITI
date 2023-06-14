#!/bin/bash

# Define the insertdata function that inserts data from a file into a database table called invdata
function insertdata {
  echo "Inserting data into database table invdata"
  echo -n "Enter path of the data file: "
  read FILEPATH
  
  # Get the name of the database and table from the environment variables
  DBNAME=$MYSQLDB
  TABLENAME="invdata"
  
  # Loop through each line in the file and insert it into the table
  while read -r LINE; do
    # Extract the values from the line and construct the insert statement
    ID=$(echo ${LINE} | cut -d ":" -f 1)
    CUSTOMERNAME=$(echo ${LINE} | cut -d ":" -f 2)
    DATE=$(echo ${LINE} | cut -d ":" -f 3)
    INSERTSTMT="INSERT INTO ${DBNAME}.${TABLENAME} (id, customername, date) VALUES (${ID}, '${CUSTOMERNAME}', '${DATE}')"
    
    # Execute the insert statement using mysql connection
    echo "${INSERTSTMT}" | mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} ${DBNAME}
    
    # Print a success message for each record inserted
    echo "Record inserted successfully: ${LINE}"
  done < "${FILEPATH}"
}

# Define the extractdata function that extracts data from a file and inserts it into a database table called intdet
function extractdata {
  echo "Extracting data from file and inserting into database table intdet"
  echo -n "Enter path of the data file: "
  read FILEPATH
  
  # Get the name of the database and table from the environment variables
  DBNAME=$MYSQLDB
  TABLENAME="intdet"
  
  # Loop through each line in the file and insert it into the table
  while read -r LINE; do
    # Extract the values from the line and construct the insert statement
    ID=$(echo ${LINE} | cut -d ":" -f 1)
    SERIAL=$(echo ${LINE} | cut -d ":" -f 2)
    PRODID=$(echo ${LINE} | cut -d ":" -f 3)
    QUANTITY=$(echo ${LINE} | cut -d ":" -f 4)
    UNITPRICE=$(echo ${LINE} | cut -d ":" -f 5)
    INSERTSTMT="INSERT INTO ${DBNAME}.${TABLENAME} (id, serial, prodid, quantity, unitprice) VALUES (${ID}, ${SERIAL}, ${PRODID}, ${QUANTITY}, ${UNITPRICE})"
    
    # Execute the insert statement using mysql connection
    echo "${INSERTSTMT}" | mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} ${DBNAME}
    
    # Print a success message for each record inserted
    echo "Record inserted successfully: ${LINE}"
  done < "${FILEPATH}"
}
