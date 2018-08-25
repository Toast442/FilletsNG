#!/bin/sh

SDL=$HOME/projects/root/Library/Frameworks/SDL_2.0

rm -rf Fillets.app
mkdir -p Fillets.app/Contents/MacOS
mkdir -p Fillets.app/Contents/Resources/fillets/share/games/fillets-ng
cat macfiles/Info.plist | sed -e "s/@VERSION@/${1}/" > Fillets.app/Contents/Info.plist

cp src/fillets Fillets.app/Contents/MacOS/Fillets
cp macfiles/PkgInfo Fillets.app/Contents
cp macfiles/Fillets.icns Fillets.app/Contents/Resources

mkdir -p Fillets.app/Contents/Frameworks
cp -a $SDL/* Fillets.app/Contents/Frameworks

if [ "$2" != "" ]
then
    cp -a "$2/"* Fillets.app/Contents/Resources/fillets/share/games/fillets-ng
    shift
fi

pushd Fillets.app/Contents/MacOS

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

dylib_fixup ./Fillets
popd
MACOS_APP_BIN=Fillets.app/Contents/MacOS/Fillets

for old in `otool -L $MACOS_APP_BIN | grep @rpath | cut -f2 | cut -d' ' -f1`; do
    new=`echo $old | sed -e "s/@rpath/@executable_path\/..\/Frameworks/"`
    echo "Replacing '$old' with '$new'"
    install_name_tool -change $old $new $MACOS_APP_BIN
done


