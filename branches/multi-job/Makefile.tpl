# vim: ft=make

FLAG_DONE=	.make.done

all: sql

clean: clean-sql clean-xz
	-rm ${FLAG_DONE}

clean-sql:
	-rm *.sql

clean-xz:
	-rm *.xz

sql: SQL_LIST

xz: XZ_LIST
	date +%s > ${FLAG_DONE}

