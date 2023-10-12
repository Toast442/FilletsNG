#!/bin/sh

SDL=$HOME/projects/root/Library/Frameworks/SDL_2.0

BUNDLE=Fillets.app

rm -rf ${BUNDLE}
mkdir -p ${BUNDLE}/Contents/MacOS
mkdir -p ${BUNDLE}/Contents/Resources/fillets/share/games/fillets-ng
cat macfiles/Info.plist | sed -e "s/@VERSION@/${1}/" > ${BUNDLE}/Contents/Info.plist

cp src/fillets ${BUNDLE}/Contents/MacOS/Fillets
cp macfiles/PkgInfo ${BUNDLE}/Contents
cp macfiles/Fillets.icns ${BUNDLE}/Contents/Resources

mkdir -p ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2.framework ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2_image.framework ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2_mixer.framework ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2_ttf.framework ${BUNDLE}/Contents/Frameworks

if [ "$2" != "" ]
then
    cp -a "$2/"* ${BUNDLE}/Contents/Resources/fillets/share/games/fillets-ng
    shift
fi

pushd ${BUNDLE}/Contents/MacOS

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
MACOS_APP_BIN=${BUNDLE}/Contents/MacOS/Fillets

for old in `otool -L $MACOS_APP_BIN | grep @rpath | cut -f2 | cut -d' ' -f1`; do
    new=`echo $old | sed -e "s/@rpath/@executable_path\/..\/Frameworks/"`
    echo "Replacing '$old' with '$new'"
    install_name_tool -change $old $new $MACOS_APP_BIN
done



pushd ${BUNDLE}/Contents/Frameworks > /dev/null 2>&1
signframework *
popd > /dev/null 2>&1
sign --options=runtime --entitlements=macfiles/fillets-Entitlements.plist ${BUNDLE}

VERSION=$(/usr/libexec/PlistBuddy  -c "Print CFBundleGetInfoString" ${BUNDLE}/Contents/Info.plist)

ditto -c -k --keepParent ${BUNDLE} Fillets-$VERSION.zip
