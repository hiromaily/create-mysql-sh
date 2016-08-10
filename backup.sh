#!/bin/sh
###############################################################################
# mysqldump
###############################################################################

# settings
DB_USER=root
DB_PASS=
DB_HOST=127.0.0.1
DB_NAME=hiromaily

# backup and saved period（days）
period=3

# directory for backup
dirpath=${HOME}/work/create-mysql-sh/data

# finelane (by date)
filename=`date +%y%m%d`

# mysqldump
#mysqldump -u${DB_USER} -p${DB_PASS} -h${DB_HOST} ${DB_NAME} > $dirpath/$filename.sql

expect -c "
    set timeout 30
    spawn sh -c \"mysqldump -u${DB_USER} -p${DB_PASS} -h${DB_HOST} ${DB_NAME} > ${dirpath}/${filename}.sql\"
    expect \"Enter password:\"
    send \"${DB_PASS}\n\"
    interact
    "

# change permission
chmod 700 $dirpath/$filename.sql

# delete old files
#oldfile=`date --date "$period days ago" +%y%m%d`
oldfile=`date -v-${period}d +%y%m%d`

rm -f $dirpath/$oldfile.sql
