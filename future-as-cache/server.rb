require 'sinatra'
require 'mysql2' # https://github.com/brianmario/mysql2
require 'json'
require 'concurrent'
require 'redis'

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

$r = Redis.new


get '/' do
  def f
    sleep 10
    $r.set 'rank', Time.now, ex: 10
    $r.set 'rank-stale', Time.now
  end
  rank = $r.get 'rank'
  if rank
    "#{rank}"
  else
    Concurrent::Future.new{ f }.execute
    "#{$r.get 'rank-stale'}"
  end
end

