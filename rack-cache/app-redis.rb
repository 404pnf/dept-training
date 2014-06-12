require 'sinatra'
require 'mysql2' # https://github.com/brianmario/mysql2
require 'json'
require 'redis'
require 'thread'

redis = Redis.new

def stale_while_revalidate
  Thread.new do
    def f
      sleep 3
      Time.now.to_json
    end
    require 'redis'
    redis = Redis.new
    redis.set 'flag', true
    r = f()
    redis.set 'rank', r#ex: 6 # expire after 3 second
    redis.set 'rank_stale', r
    redis.set 'flag', false
  end
end

# redis.set :rank, f
# redis.set :rank_stale, f

get '/' do
  r = redis.get 'rank'
  if r
    "#{r}\n"
  elsif redis.get 'flag' # 有人在计算了
    "#{redis.get('rank_stale')}\n"
  else
    stale_while_revalidate
    "#{redis.get('rank_stale')}\n"
  end
end

