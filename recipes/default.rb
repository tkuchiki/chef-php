remi_rpm = "#{Chef::Config[:file_cache_path]}/#{File.basename(node[:php][:remi_release])}"

remote_file "#{remi_rpm}" do
  source node[:php][:remi_release]
  not_if "rpm -q remi-release"
end

rpm_package remi_rpm do
  action :install
  not_if "rpm -q remi-release"
end

file remi_rpm do
  action :delete
end

node[:php][:packages].each do |pkg|
  yum_package pkg do
    action  :install
    options "--enablerepo=remi,remi-php#{node[:php][:version].to_s.delete('.')}"
  end
end

template "/etc/php.ini" do
  source  "php.ini.erb"
end

template "/etc/php-fpm.conf" do
  source   "php-fpm.conf.erb"
  notifies :start,  "service[php-fpm]"
  notifies :reload, "service[php-fpm]"
  only_if  { node[:php][:packages].include?("php-fpm") }
end

template "/etc/php-fpm.d/www.conf" do
  source   "www.conf.erb"
  notifies :start,  "service[php-fpm]"
  notifies :reload, "service[php-fpm]"
  only_if  { node[:php][:packages].include?("php-fpm") }
end

service "php-fpm" do
  action   [ :enable ]
  supports :restart => true, :reload => true
  only_if  { node[:php][:packages].include?("php-fpm") }
end
