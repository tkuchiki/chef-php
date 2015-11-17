# chef-php
chef cookbook for php

# Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
`[:php][:remi_release]` | remi-release rpm | String | "http://rpms.famillecollet.com/enterprise/remi-release-#{node[:platform_version].to_i}.rpm",
`[:php][:version]` | php version | String or Float | "5.6"
`[:php][:packages]` | yum packages | Array | []
`[:php_fpm][:global_config]` | php-fpm [global] config | Hash | See attributes/default.rb
`[:php_fpm][:www_config]` | php-fpm [www] config | Hash | See attributes/default.rb

# Example

## Attributes

```
{
  "php": {
    "packages": [
      "php",
      "php-common",
      "php-bcmath",
      "php-pdo",
      "php-cli",
      "php-mbstring",
      "php-gd"
    ]
  }
}
```
