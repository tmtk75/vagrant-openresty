Name:		ngx_openresty
Version:	{{OPENRESTY_VERSION}}
Release:	2_kii%{?dist}
Summary:	a fast web app server by extending nginx

Group:		Productivity/Networking/Web/Servers
License:	BSD
URL:		openresty.org
Source0:	http://openresty.org/download/ngx_openresty-%{version}.tar.gz
Source1:	https://github.com/brnt/openresty-rpm-spec/raw/master/nginx.init
BuildRoot:	%(mktemp -ud %{_tmppath}/ngx_openresty-%{version}-%{release}-XXXXXX)

BuildRequires:	sed openssl-devel pcre-devel readline-devel
Requires:	openssl pcre readline
Requires(pre):	shadow-utils
Conflicts: nginx

%define user nginx
%define homedir %{_usr}/local/openresty
%define nginx_confdir   %{_sysconfdir}/nginx

%description
OpenResty (aka. ngx_openresty) is a full-fledged web application server by bundling the standard Nginx core, lots of 3rd-party Nginx modules, as well as most of their external dependencies.


%prep
%setup -q


%build
./configure --with-ipv6 --with-pcre-jit --with-luajit \
    --with-http_realip_module \
    --user=%{user} \
    --group=%{user} \
    --conf-path=%{nginx_confdir}/nginx.conf \
    --pid-path=%{_localstatedir}/run/nginx.pid \
    --lock-path=%{_localstatedir}/lock/subsys/nginx

make %{?_smp_mflags}


%pre
getent group %{user} || groupadd -f -r %{user}
getent passwd %{user} || useradd -M -d %{homedir} -g %{user} -s /bin/nologin %{user}


%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}
%{__install} -p -D -m 0755 %{SOURCE1} %{buildroot}%{_initrddir}/nginx
mkdir %{buildroot}%{nginx_confdir}/conf.d


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
#%{homedir}/*

%{_initrddir}/nginx
%{homedir}/luajit/*
%{homedir}/lualib/*
%{homedir}/nginx
%{homedir}/nginx/html/*
%{homedir}/nginx/logs
%{homedir}/nginx/sbin
%{homedir}/nginx/sbin/nginx
%{homedir}/bin/resty

%dir %{nginx_confdir}
%dir %{nginx_confdir}/conf.d
%{nginx_confdir}/fastcgi.conf.default
%{nginx_confdir}/fastcgi_params.default
%{nginx_confdir}/mime.types.default
%{nginx_confdir}/nginx.conf.default
%{nginx_confdir}/scgi_params.default
%{nginx_confdir}/uwsgi_params.default

%config %{nginx_confdir}/fastcgi.conf
%config %{nginx_confdir}/fastcgi_params
%config %{nginx_confdir}/koi-utf
%config %{nginx_confdir}/koi-win
%config %{nginx_confdir}/mime.types
%config %{nginx_confdir}/nginx.conf
%config %{nginx_confdir}/scgi_params
%config %{nginx_confdir}/uwsgi_params
%config %{nginx_confdir}/win-utf


%postun


%changelog

