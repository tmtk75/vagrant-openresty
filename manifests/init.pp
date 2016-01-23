package {[
    "rpmdevtools",
    "yum-utils",
    "make",
    "openssl-devel",
    "pcre-devel",
    "readline-devel",
    "gcc-c++",
    "curl",
    "vim-enhanced",
  ]:
  ensure => installed,
}

service { iptables:
  ensure => stopped,
}
