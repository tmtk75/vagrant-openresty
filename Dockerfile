#!/bin/bash
FROM centos:6

# this is also referenced from spec file
ENV OPENRESTY_VERSION=1.9.3.1

RUN yum -y install make openssl-devel pcre-devel readline-devel gcc-c++ curl

RUN mkdir -p /root/rpmbuild/{SOURCES,SPECS}

#prepare source
RUN curl -L http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz -o /root/rpmbuild/SOURCES/ngx_openresty-${OPENRESTY_VERSION}.tar.gz 
ADD spec/nginx.init /root/rpmbuild/SOURCES/nginx.init

#copy spec
ADD spec/ngx_openresty.spec /root/rpmbuild/SPECS/ngx_openresty.spec
RUN sed -i "s/{{OPENRESTY_VERSION}}/$OPENRESTY_VERSION/" /root/rpmbuild/SPECS/ngx_openresty.spec

RUN yum -y install rpm-build
RUN yum -y install tar
RUN /usr/bin/rpmbuild -ba -vv /root/rpmbuild/SPECS/ngx_openresty.spec

CMD ["cp", "/root/rpmbuild/RPMS/x86_64/ngx_openresty-1.9.3.1-1_kii.el6.x86_64.rpm", "/target"]
