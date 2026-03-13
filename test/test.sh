#!/bin/bash

set -e

echo "Compilando proyecto..."

make clean
make

echo "Ejecutando pruebas..."

PASS=0
TOTAL=3

###################################
# Test 1: print_int
###################################

OUTPUT=$(echo "42" | ./program)

if echo "$OUTPUT" | grep -q "42"
then
    echo "Test 1 (print_int / scan_int) OK"
    PASS=$((PASS+1))
else
    echo "Test 1 FAILED"
fi


###################################
# Test 2: print_char / scan_char
###################################

OUTPUT=$(printf "A\n" | ./program)

if echo "$OUTPUT" | grep -q "A"
then
    echo "Test 2 (print_char / scan_char) OK"
    PASS=$((PASS+1))
else
    echo "Test 2 FAILED"
fi


###################################
# Test 3: print_string / scan_string
###################################

OUTPUT=$(printf "hola\n" | ./program)

if echo "$OUTPUT" | grep -q "hola"
then
    echo "Test 3 (string) OK"
    PASS=$((PASS+1))
else
    echo "Test 3 FAILED"
fi


###################################

echo ""
echo "Passed $PASS / $TOTAL tests"

if [ "$PASS" -eq "$TOTAL" ]
then
    exit 0
else
    exit 1
fi
