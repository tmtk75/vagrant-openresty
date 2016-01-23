#!/bin/bash

# this is also referenced from spec file
export OPENRESTY_VERSION=${1-1.9.7.2}
export BUILD_HOME=/root
export SPEC_HOME=/vagrant/spec
#sudo yum -y install make openssl-devel pcre-devel readline-devel gcc-c++ curl

if [ -e "ngx_openresty-${OPENRESTY_VERSION}-2_kii.el6.x86_64.rpm" ]; then
  exit 0
fi

mkdir -p $BUILD_HOME/rpmbuild/{SOURCES,SPECS}

# prepare source
curl -s \
     -L http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz \
     -o $BUILD_HOME/rpmbuild/SOURCES/ngx_openresty-${OPENRESTY_VERSION}.tar.gz 
cp $SPEC_HOME/nginx.init $BUILD_HOME/rpmbuild/SOURCES

# copy spec
cp $SPEC_HOME/ngx_openresty.spec $BUILD_HOME/rpmbuild/SPECS
sed -i "s/{{OPENRESTY_VERSION}}/$OPENRESTY_VERSION/" \
	$BUILD_HOME/rpmbuild/SPECS/ngx_openresty.spec

rpmbuild -ba -vv $BUILD_HOME/rpmbuild/SPECS/ngx_openresty.spec

cp /root/rpmbuild/RPMS/x86_64/ngx_openresty-${OPENRESTY_VERSION}-*_kii.el6.x86_64.rpm /vagrant
