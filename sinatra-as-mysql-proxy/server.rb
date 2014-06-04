require 'sinatra'
require 'mysql2'
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
json = results.to_a.to_json # 必须先转为数组，不能直接转到json
                            # result的类是Mysql2的

get '/' do
  sleep 2
  "#{json}"
end

