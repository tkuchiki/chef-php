default[:php] = {
  :remi_release => "http://rpms.famillecollet.com/enterprise/remi-release-#{node[:platform_version].to_i}.rpm",
  :version      => "5.6",
  :packages     => [
  ],
}

default[:php_fpm] = {
  :global_config => {
    "pid"       => "/var/run/php-fpm/php-fpm.pid",
    "error_log" => "/var/log/php-fpm/error.log",
    "daemonize" => "yes",
  },
  :www_config => {
    "listen" => "127.0.0.1:9000",
    "listen.allowed_clients" => "127.0.0.1",
    "user"   => "apache",
    "group"  => "apache",
    "pm"     => "dynamic",
    "pm.max_children"      => 50,
    "pm.start_servers"     => 5,
    "pm.min_spare_servers" => 5,
    "pm.max_spare_servers" => 35,
    "php_admin_value[error_log]"      => "/var/log/php-fpm/www-error.log",
    "php_admin_flag[log_errors]"      => "on",
    "php_value[session.save_handler]" => "files",
    "php_value[session.save_path]"    => "/var/lib/php/session",
    "php_value[soap.wsdl_cache_dir]"  => "/var/lib/php/wsdlcache",
  }
}
