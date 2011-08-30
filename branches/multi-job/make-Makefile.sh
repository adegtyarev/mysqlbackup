#!/bin/sh

DBS=`mysql -Bse "SHOW DATABASES;"`

for db in ${DBS}; do
	SQL_LIST="${SQL_LIST} $db.sql"
	XZ_LIST="${XZ_LIST} ${db}.sql.xz"
done

sed -e "s#SQL_LIST#${SQL_LIST}#" -e "s#XZ_LIST#${XZ_LIST}#" Makefile.tpl \
	> Makefile

for db in ${DBS}; do
	echo "
${db}.sql.xz: ${db}.sql
	-rm ${db}.sql.xz
	xz ${db}.sql

${db}.sql:
	./mysqlbackup -d . -z no -m no -L ./${db}.lock ${db}" >> Makefile
done
