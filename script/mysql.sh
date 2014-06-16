#!/bin/sh
echo "Starting..."

#Stop on error.
set -e

#Output name.
PKG_NAME=Mysql

#Sources and dependency names.
ZIP=zip-3.0-11
MYSQL=mysql-5.5.35-1
LIBCRYPT=libcrypt0-1.1-1
LIBOPENSSL=libopenssl100-1.0.1h-1
PERL=perl-5.14.2-3
LIBGDM=libgdbm4-1.8.3-20
LIBDB=libdb4.8-4.8.30-1
LIBSSP=libssp0-4.8.3-1

#Clean up.
rm -rf .working_dir
mkdir .working_dir
cd .working_dir

#Grab sources and dependencies.
echo "Grabbing sources..."
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/zip/$ZIP.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/mysql/$MYSQL.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86_64/release/crypt/libcrypt0/$LIBCRYPT.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/openssl/libopenssl100/$LIBOPENSSL.tar.xz
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/perl/$PERL.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gdbm/libgdbm4/$LIBGDM.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/db/db4.8/libdb4.8/$LIBDB.tar.bz2
wget ftp://mirrors.kernel.org/sourceware/cygwin/x86/release/gcc/libssp0/$LIBSSP.tar.xz

#Unzip.
echo "Unzipping sources..."
tar xjf $ZIP.tar.bz2 -C / #Needed for packaging.
tar xj $MYSQL.tar.xz
tar xjf $LIBCRYPT.tar.bz2
tar xj $LIBOPENSSL.tar.xz
tar xjf $PERL.tar.bz2
tar xjf $LIBGDM.tar.bz2
tar xjf $LIBDB.tar.bz2
tar xj $LIBSSP.tar.xz

#Move sources in place for packaging.
echo "Creating package basis..."
## Bin directory.
mkdir $PKG_NAME
mkdir $PKG_NAME/bin
cp -r usr/bin/* $PKG_NAME/bin
## Lib directory.
mkdir $PKG_NAME/lib
cp -r usr/lib/* $PKG_NAME/lib
## Include and Share directory.
mkdir $PKG_NAME/usr
###cp -r usr/include $PKG_NAME/usr
cp -r usr/share $PKG_NAME/usr

#Build package.
echo "Building package..."
cd $PKG_NAME
zip -r $PKG_NAME.mxt3 .
mv $PKG_NAME.mxt3 ../../
echo "Created package $PKG_NAME.mxt3 successfully!" 



