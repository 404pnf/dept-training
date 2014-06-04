require 'sinatra'
require 'mysql2'
require 'json'

client = Mysql2::Client.new(
  host: 'localhost',
  database: 'iyc_whx',
  username: 'py',
  password: 'pengyou'
  )

client = Mysql2::Client.new(
  host: '129.0.0.47',
  database: 'iyc_whx',
  username: 'py',
  password: 'pengyou'
  )

results = client.query("SELECT * FROM rank WHERE sales>10")

json = results.to_json

get '/' do
  sleep 2
  json
end

