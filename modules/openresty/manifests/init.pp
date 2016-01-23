class openresty {
  include install
  include config
  include service
  Class[install] -> Class[config] ~> Class[service]
}

class openresty::install {
  package { ngx_openresty: 
    provider => rpm,
    source => "/vagrant/ngx_openresty-1.9.7.2-2_kii.el6.x86_64.rpm",
  }
}

class openresty::config {
  file { "/etc/nginx/nginx.conf":
    ensure  => present,
    content => template("openresty/nginx.conf"),
  }
  file { "/etc/nginx/conf.d/default.conf":
    ensure  => present,
    content => template("openresty/default.conf"),
  }
  file { "/etc/nginx/conf.d/rate-limit.conf":
    ensure => absent,
  }
  file { "/vagrant/log":
    ensure => directory,
    mode   => 0755,
  }
  -> file { "/vagrant/log/nginx":
    ensure => directory,
    mode   => 0755,
  }
}

class openresty::service {
  service { nginx:
    ensure => running,
  }
}
