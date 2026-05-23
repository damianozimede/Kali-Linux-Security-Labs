#!/bin/bash


number=$((RANDOM % 10 + 1))
echo "=== Number Guessing Game ==="
echo "I'm thinking of a number between 1 and 10!"

while true; do
    echo -n "Your guess: "
    read guess
    if [ $guess -eq $number ]; then
        echo "Correct! The number was $number!"
        break
    elif [ $guess -lt $number ]; then
        echo "Too low! Try again."
    else
        echo "Too high! Try again."
    fi
done
