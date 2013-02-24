#!/bin/sh

cat macfiles/Info.plist | sed -e "s/@VERSION@/${1}/" > Fillets.app/Contents/Info.plist

cp macfiles/PkgInfo Fillets.app/Contents
cp macfiles/Fillets.icns Fillets.app/Contents/Resources

cd Fillets.app/Contents/MacOS

function dylib_fixup {

  DYLIBS=`otool -X -L $1 | grep dylib | grep -v /usr/lib | grep -v Frameworks | awk -F \( '{ print $1 }'`


  for dl in $DYLIBS
  do
  	install_name_tool -change $dl @executable_path/`basename $dl` $1
	if ! test -f `basename $dl`
	then 
  		cp $dl .
		dylib_fixup `basename $dl`
	fi
  done
}

dylib_fixup ./fillets
