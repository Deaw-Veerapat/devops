#!/bin/bash
set -x
set -e
set -o pipefail
name="veerapat"
surname="pirultham"
echo "I am $name surname is $surname"
a=10
b=11
count=1
if [ "$a" -lt "$b" ];then
	echo "a lessthan b $((b-a))"
elif [ "$a" -gt "$b" ];then
	echo "a greterthan b $((a-b))"
else
	echo "equal"
fi
for i in {1..10}
do
	echo "$i"
done
while [ $count -lt 5 ]
do
	echo "$count"
	((count++))
done

trap 'echo "โดน Ctrl+C แล้ว!"; exit' SIGINT

echo "รอคุณกด Ctrl+C"
while true; do
  sleep 1
done
