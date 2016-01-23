package {[
  "vim-enhanced",
  "rpmdevtools",
  "yum-utils", "make", "openssl-devel", "pcre-devel", "readline-devel", "gcc-c++", "curl" ]:
  ensure => installed,
}

include openresty 
