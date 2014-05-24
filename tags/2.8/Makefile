#
# Source makefile
#
# $Id$

CATEGORY=databases
NAME=mysqlbackup
TARBALL_SFX=tar.gz

REMOTE_USER=nice
REMOTE_HOST=nice.renatasystems.org
REMOTE_PATH=~/src

VERSION=${NAME}-`head -1 VERSION`

DIRECTORIES=

EXEC_AFTER=

.SILENT:

all: clean tarball

deb: tarball
	mkdir equivs
	sed -E "s/%%VERSION%%/`head -1 VERSION`/g" \
		mysqlbackup.debian.in > equivs/mysqlbackup.debian
	gzip -9 -c ${VERSION}/mysqlbackup.1 > equivs/mysqlbackup.1.gz
	cp ${VERSION}/mysqlbackup equivs/mysqlbackup
	cp ${VERSION}/LICENSE equivs/LICENSE
	cd equivs && equivs-build mysqlbackup.debian
	mv equivs/mysqlbackup*.deb .
	lintian mysqlbackup*.deb    

tarball: clean
	mkdir ${VERSION}
	sed "s/VERSION/${VERSION}/g;" README > ${VERSION}/README
	cp VERSION RELNOTES TODO LICENSE ${VERSION}/
	cp 200.mysqlbackup.* ${VERSION}/
	sed -E "s/%%VERSION%%/`head -1 VERSION`/g" \
		 mysqlbackup > ${VERSION}/mysqlbackup
	chmod 0755 ${VERSION}/mysqlbackup
	help2man \
		--version-option "-V" \
		--help-option "-H" \
		--no-info \
		-n "creates MySQL backups on a periodic basis" \
		--source="mysqlbackup `head -1 VERSION`" \
		--opt-include=mysqlbackup.1.include \
		--output=${VERSION}/mysqlbackup.1 \
		${VERSION}/mysqlbackup
	tar zcf ${VERSION}.${TARBALL_SFX} ${VERSION}
	echo "==>  tarball for ${VERSION} created"
	tar tzf ${VERSION}.${TARBALL_SFX}

upload: tarball
	[ -f ${VERSION}.${TARBALL_SFX} ] || exit 1;
	cat ${VERSION}.${TARBALL_SFX} | ssh ${REMOTE_USER}@${REMOTE_HOST} "\
		cd ${REMOTE_PATH};\
		if [ ! -d ${CATEGORY}/${NAME} ]; then\
			/bin/mkdir -p ${CATEGORY}/${NAME};\
		fi;\
		/bin/cat >${CATEGORY}/${NAME}/${VERSION}.${TARBALL_SFX}\
	"
	/bin/rm -r "${VERSION}"/* && /bin/rmdir ${VERSION} && /bin/rm ${VERSION}.${TARBALL_SFX}
	echo "Done"

clean:
	if [ -d ${VERSION} ]; then rm -r "${VERSION}"/* && rmdir ${VERSION}; fi
	if [ -f ${VERSION}.${TARBALL_SFX} ]; then rm ${VERSION}.${TARBALL_SFX}; fi
	rm -f mysqlbackup_*.deb
	rm -rf equivs
