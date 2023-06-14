source dbops.sh
CURUSER=""
function runMenu {
	echo "Enter option (1-6)"
local OPT=0
while [ ${OPT} -ne 6 ]
do
echo -e "\t1-Authenitcate"
echo -e "\t2-Query a customer"
echo -e "\t3-Insert a new customer"
echo -e "\t4-Delete an existing customer"
echo -e "\t5-Quit"
echo -e "Please choose a menu from 1 to 5"
read OPT
case "${OPT}" in
	"1")
		authenticate
		;;
	"2")
		query
		;;
	"3")
		insertData
		;;
	"4")
		delete
		;;
	"5")
		echo "Bye bye.."
		;;
	*)
		echo "Sorry, invalid option, try again"
esac
done
}
