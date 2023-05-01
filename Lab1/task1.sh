#Task 1 
#How to perform floatinf point operation
#!/bin/bash
## we can use bc to make mathematical operation on two float numbers only
NUM1=1.2
NUM2=1.1

#Sum of two float numbers
echo "sum of $NUM1 + $NUM2 = " $(echo $NUM1 + $NUM2 | bc)

#Substract of two float numbers
echo "substract of $NUM1 - $NUM2 = " $(echo $NUM1 - $NUM2 | bc)

#multiply of two float numbers
echo "multiply of $NUM1 * $NUM2= " $(echo $NUM1 \* $NUM2 | bc)

#divide of two float numbers
echo "Divide of $NUM1 / $NUM2 = " $(echo $NUM1 / $NUM2 | bc)
