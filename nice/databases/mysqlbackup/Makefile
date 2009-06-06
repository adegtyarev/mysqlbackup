#!/bin/sh
#
# Source makefile
#
# $Id: Makefile,v 1.4 2008-11-20 09:16:30 alexey Exp $

CATEGORY=databases
NAME=mysqlbackup
TARBALL_SFX=tar.gz

REMOTE_USER=nice
REMOTE_HOST=nice.renatasystems.org
REMOTE_PATH=~/src

VERSION=${NAME}-`/usr/bin/head -1 VERSION`

FILES=mysqlbackup
DIRECTORIES=

EXEC_AFTER=

.SILENT:

all: clean tarball upload
tarball: clean
	echo "Creating distributive of ${NAME}: ${VERSION}.${TARBALL_SFX}"
	/bin/mkdir ${VERSION}
	/usr/bin/sed "s/VERSION/${VERSION}/g;" README > ${VERSION}/README
	/bin/cp VERSION RELNOTES ${VERSION}
	if [ -f Makefile.in ]; then\
		if [ -f ${VERSION}/Makefile ]; then\
			echo "conflict: ${VERSION}/Makefile already exist.";\
			exit 1;\
		fi;\
		/bin/cp Makefile.in ${VERSION}/Makefile;\
	fi
	if [ ! -z "${DIRECTORIES}" ]; then\
		/bin/cp -R ${DIRECTORIES} ${VERSION};\
	fi
	if [ ! -z "${FILES}" ]; then\
		/bin/cp ${FILES} ${VERSION};\
	fi
	if [ ! -z "${EXEC_AFTER}" ]; then\
		exec "${EXEC_AFTER}";\
	fi
	/usr/bin/sed -i "" -e "s/%%VERSION%%/`/usr/bin/head -1 VERSION`/g" ${VERSION}/mysqlbackup
	/usr/local/bin/help2man \
		--version-option "-V" \
		--help-option "-H" \
		--no-info \
		--source=FreeBSD \
		--opt-include=mysqlbackup.1.include \
		--output=${VERSION}/mysqlbackup.1 \
		${VERSION}/mysqlbackup && \
	echo "==>  manpage mysqlbackup(1) created"
	/usr/bin/nroff -mandoc <${VERSION}/mysqlbackup.1 |\
	/usr/local/bin/man2html -seealso \
	-title "mysqlbackup - create everyday MySQL-databases backup" |\
	/usr/local/bin/tidy -quiet -asxml -utf8 >${VERSION}/mysqlbackup.html && \
	echo "==>  html page for mysqlbackup created"
	/usr/bin/find ${VERSION} -type d -name CVS | /usr/bin/xargs /bin/rm -rf
	/usr/bin/tar zcf ${VERSION}.${TARBALL_SFX} ${VERSION}

upload: tarball
	[ -f ${VERSION}.${TARBALL_SFX} ] || exit 1;
	/bin/cat ${VERSION}.${TARBALL_SFX} | /usr/bin/ssh ${REMOTE_USER}@${REMOTE_HOST} "\
		cd ${REMOTE_PATH};\
		if [ ! -d ${CATEGORY}/${NAME} ]; then\
			/bin/mkdir -p ${CATEGORY}/${NAME};\
		fi;\
		/bin/cat >${CATEGORY}/${NAME}/${VERSION}.${TARBALL_SFX}\
	"
	/bin/rm -r "${VERSION}"/* && /bin/rmdir ${VERSION} && /bin/rm ${VERSION}.${TARBALL_SFX}
	echo "Done"

clean:
	if [ -d ${VERSION} ]; then /bin/rm -r "${VERSION}"/* && /bin/rmdir ${VERSION}; fi
	if [ -f ${VERSION}.${TARBALL_SFX} ]; then /bin/rm ${VERSION}.${TARBALL_SFX}; fi
