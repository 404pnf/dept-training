require 'sinatra'
require 'mysql2' # https://github.com/brianmario/mysql2
require 'json'

set :bind, '129.0.0.47'

client = Mysql2::Client.new(
  host: 'localhost',
  # host: '129.0.0.47',
  database: 'iyc_whx',
  username: 'py',
  password: 'pengyou'
  )

results = client.query("SELECT * FROM rank WHERE sales>10")
json = results.to_a.to_json # 不能直接转到json。result的类是Mysql2下某个类

get '/' do
  sleep 5
  "#{json}"
end

