require 'sinatra'
require 'mysql2' # https://github.com/brianmario/mysql2
require 'json'
# require 'rack/cache'
# require_relative'rack_capabilities.rb'
# require_relative 'cache.rb'


# use Rack::Capabilities
# use Rack::CacheWhileRevalidate
# use Rack::Cache

# set :bind, '129.0.0.47'

# client = Mysql2::Client.new(
#   host: 'localhost',
#   # host: '129.0.0.47',
#   database: 'iyc_whx',
#   username: 'py',
#   password: 'pengyou'
#   )

# results = client.query("SELECT * FROM rank WHERE sales>10")
# json = results.to_a.to_json # 不能直接转到json。result的类是Mysql2下某个类

get '/' do
  # cache_control :public, :max_age => 10
  sleep 5
  "#{Time.now}\n"
end

