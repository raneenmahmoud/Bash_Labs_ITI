#!/bin/bash
#task2
#How to check a number is valid floating number
## Parameters
##   fisrt number
##   second number
## Exit codes:
##    0: success
##    1: not enough parameters
##    2: divide by zero
##    3: NUM1 is not a number
##    4: NUM2 is not a number

## Check for numbers of parameters
[ ${#} -ne 2 ] && exit 1

##Check for division by zero
[ ${2} == 0 ] || [ ${2} == "0.0" ] && exit 2

##Assign values to parameters
NUM1=${1}
NUM2=${2}

##Check for floating number 
echo "${NUM1}" | grep -Eq '^[-+]?[0-9]+\.?[0-9]*$' || exit 3
echo "${NUM2}" | grep -Eq '^[-+]?[0-9]+\.?[0-9]*$' || exit 4

## sum
echo "sum of ${NUM1} + ${NUM2} = " $(echo ${NUM1} + ${NUM2} | bc)

## subtract
echo "subtract of ${NUM1} - ${NUM2} = " $(echo ${NUM1} - ${NUM2} | bc)

## multiply
echo "multiplication of ${NUM1} * ${NUM2} = " $(echo ${NUM1} \* ${NUM2} | bc)

## division
echo "division of ${NUM1} / ${NUM2} = " $(echo ${NUM1} / ${NUM2} | bc)

