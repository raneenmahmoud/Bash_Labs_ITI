source checker.sh

##Function check if id exists or no
##Exit codes:
#	0: Success
#	1: not enough parameter
#	2: Not an integer
#	3: id exists

function checkID {
	[ ${#} -ne 1 ] && return 1
	checkInt ${1}
	[ ${?} -ne 0 ] && return 2
	RES=$(mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "select id from ${MYSQLDB}.inv where (id=${1})")
        [ ! -z "${RES}" ] && return 3
	return 0
}

function authenticate {
	echo "Authentication.."
	CURUSER=""
	echo -n "Enter your username: "
	read USERNAME
	echo -n "Enter your password: "
	read -s PASSWORD
	### Start authentication. Query database for the username/password
	RES=$(mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "select username from ${MYSQLDB}.users where (username='${USERNAME}') and (password=md5('${PASSWORD}'))")
	if [ -z "${RES}" ]
	then
		echo "Invalid credentials"
		return 1
	else
		CURUSER=${USERNAME}
		echo "Welcome ${CURUSER}"
	fi
	return 0
}



## Function to list every customer with products he has
function query {
	echo "Query"
	if [ -z ${CURUSER} ] 
	then
		echo "Authenticate first"
		return 1
	fi
	echo "Enter invoice ID: "
	read ID
	checkInt ${ID}
	while [ $? -ne 0 ]
	do
		echo "Error: Invalid input. Enter a valid ID: "
		read ID
		checkInt ${ID}
	done

	## Fetch the details from the database
	mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "select * from ${MYSQLDB}.inv where (id=${ID} )"

	echo "Details:"
	echo "Product ID     Quantity      Unit Price     Total Product"
	echo "--------------------------------------------------------"

	## Fetch the details of all products from the database
	mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "select * from ${MYSQLDB}.intdet where (id=${ID})" | while read line
	do
		IFS=":" read -r prodid quantity unitprice <<< "${line}"
		totalproduct=$((${quantity} * ${unitprice}))
		echo "${prodid}                 ${quantity}            ${unitprice}             ${totalproduct}"
	done
}

## Function to insert data into the table using mysql
function insertData {
	echo "inserting data"
	if [ -z ${CURUSER} ] 
	then
		echo "Authenticate first"
		return 1
	fi
	echo "Enter file name to read data from: "
	read FILENAME
	checkFile ${FILENAME}
	while [ $? -ne 0 ]
	do
		echo "Error: File does not exist. Enter a valid file name: "
		read FILENAME
		checkFile ${FILENAME}
	done

	echo "Enter table name to insert data into: "
	read TABLENAME

	## Fetch the data from the file and insert into the database
	while IFS=":" read -r id serial prodid quantity unitprice
	do
		mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "insert into ${MYSQLDB}.${TABLENAME} values(${id},${serial},${prodid},${quantity},${unitprice})"
	done < "${FILENAME}"
	echo "Data inserted successfully."
}

## Function to delete records from the table using mysql
function delete {
	echo "Deleting data"
	if [ -z ${CURUSER} ] 
	then
		echo "Authenticate first"
		return 1
	fi
	echo "Enter table name to delete data from: "
	read TABLENAME

	echo "Enter ID to delete: "
	read ID
	checkID ${ID}
	while [ $? -ne 0 ]
	do
		echo "Error: Invalid input. Enter a valid ID: "
		read ID
		checkInt ${ID}
	done

	## Delete the matching records from the database
	mysql -h ${MYSQLHOST} -u ${MYSQLUSER} -p${MYSQLPASS} -e "delete from ${MYSQLDB}.${TABLENAME} where id=${ID}"
	echo "Records deleted successfully."
}
