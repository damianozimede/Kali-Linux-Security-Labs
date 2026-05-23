#!/bin/bash


echo "What is your name?"
read name
echo "What time of day is it? (morning/afternoon/evening)"
read time

if [ "$time" = "morning" ]; then
    echo "Good morning, $name!"
elif [ "$time" = "afternoon" ]; then
    echo "Good afternoon, $name!"
else
    echo "Good evening, $name!"
fi
