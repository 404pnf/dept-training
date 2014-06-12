require_relative 'server'
require 'rack/cache'

use Rack::Cache,
  :verbose     => true,
  :metastore   => 'memcached://localhost:11211/meta',
  :entitystore => 'memcached://localhost:11211/body',
  :default_ttl => 10,
  :allow_reload => false

run Sinatra::Application
