#!/bin/sh

set -e

cd `dirname $0`

urweb -dbms sqlite dbupload2

rm -rf dbupload2.db || true
sqlite3 dbupload2.db < dbupload2.sql

MYPID=/tmp/dbupload2.pid
rm -f $MYPID

./dbupload2.exe -p 8083 -m 10000000 &
echo $! >> $MYPID
sleep 1

rm -rf dupload2.bin

# create two files: one empty and one full
EMPTY=/tmp/dbupload2-empty
FULL=/tmp/dbupload2-full
touch $EMPTY
# just some garbage big enough for our needs
dd if=/dev/zero of=$FULL bs=1000000 count=1

# should fail
curl --verbose -F"operation=upload" -F"filename=@$EMPTY" http://localhost:8083/Blabla/bla

# should work
curl --verbose -F"Param=HI THERE" -F"File=@$FULL" http://localhost:8083/handle

# download and compare
curl --verbose -o dbupload2-full -X GET http://localhost:8083/getImage/1
cmp dbupload2-full $FULL

echo killing $(cat $MYPID)
kill `cat $MYPID`
