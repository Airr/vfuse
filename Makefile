# Shameless fork from the far superior https://github.com/clburlison/pinpoint/blob/master/Makefile

PKGTITLE="vfuse"
PKGVERSION="1.0.6"
PKGID=com.github.vfuse
PROJECT="vfuse"

#################################################

##Help - Show this help menu
help: 
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

##  clean - Clean up temporary working directories
clean:
	rm -f ./vfuse*.{dmg,pkg}
	rm -f ./pkgroot/usr/local/vfuse/*.pyc

##  pkg - Create a package using pkgbuild
pkg: clean
	pkgbuild --root pkgroot --scripts scripts --identifier ${PKGID} --version ${PKGVERSION} --ownership recommended ./${PKGTITLE}-${PKGVERSION}.pkg

##  dmg - Wrap the package inside a dmg
dmg: pkg
	rm -f ./${PROJECT}*.dmg
	rm -rf /tmp/${PROJECT}-build
	mkdir -p /tmp/${PROJECT}-build/
	cp ./README.md /tmp/${PROJECT}-build
	cp -R ./${PKGTITLE}-${PKGVERSION}.pkg /tmp/${PROJECT}-build
	hdiutil create -srcfolder /tmp/${PROJECT}-build -volname "${PROJECT}" -format UDZO -o ${PROJECT}-${PKGVERSION}.dmg
	rm -rf /tmp/${PROJECT}-build
