#!/bin/bash
username=$(whoami)

last_number=0
for file in "$username"-*; do
    if [ -f "$file" ]; then
        num=$(echo "$file" | grep -o '[0-9]*' | tail -1)
        if [ "$num" -gt "$last_number" ]; then
            last_number=$num
        fi
    fi
done

for i in {1..25}; do
    current_number=$((last_number + i))
    touch "$username-$current_number"
done

ls -l "$username"-*