#!/bin/sh
###############################################################################
# create test database
###############################################################################

# settings
DB_NAME=hiromaily2
DB_USER=root
DB_PASS=
DB_HOST=127.0.0.1
WORK_DIR=${HOME}/work/create-mysql-sh

# directory for restore
dirpath=${WORK_DIR}/data

# finelane (by date)
filename=`date +%y%m%d`

# Create TestDB
expect -c "
    set timeout 30
    spawn sh -c \"mysql -u${DB_USER} -p${DB_PASS} -h${DB_HOST} < ${WORK_DIR}/sql/createdb.sql\"
    expect \"Enter password:\"
    send \"${DB_PASS}\n\"
    interact
    "

# restore
expect -c "
    set timeout 30
    spawn sh -c \"mysql -u${DB_USER} -p${DB_PASS} -h${DB_HOST} ${DB_NAME} < ${dirpath}/${filename}.sql\"
    expect \"Enter password:\"
    send \"${DB_PASS}\n\"
    interact
    "
