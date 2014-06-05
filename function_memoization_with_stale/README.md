# Caching with stale

Yes. Oh bah Nginx stale. <http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache_use_stale>

# Backend is slow?

  ```Ruby
  def f
      sleep 4
      Time.now
  end

  get '/' do
      f
  end
  ```
# Solutions

## 1. Cache the result with function memoization.

<https://github.com/search?q=ruby+memo&type=Repositories&ref=searchresults>

Not good enough. Because no cache expiration support.

## 2. Solution number 1 with expiration support

<https://github.com/educabilia/memmo> or any cache solution supports expiration, redis, memcache.

Not good enough. Because

1. Doesn't support functions take arguments (referring to memmo gem, easier to fix).
1. Doesn't prevent re-calculation while updating the result.
1. While updating cache, more requests coming for result. Because there is no result available, all requests going to backend, eating more resources, making it even more slower to get the result, making even more requests going to backend

## 3. Solution number 2 with support for servering stale result while updating cache

1. expose the function result over http
1. use Nginx proxy_cache_with_stale

Not good enough. Because functions need to expose their result over http to make it work.

# concurrent-ruby comes to resue?

  ```Ruby
  require 'sinatra'
  require 'concurrent'

  def f
    sleep 4 # slow query in db
    Time.now
  end

  #  FIXME
  # gemify this pattern in a ruby gem
  task = Concurrent::TimerTask.new(execution_interval: 5, timeout_interval: 5) { f }

  #  FIXME
  # name collision with sinatra run!
  # sinatra warning: [DEPRECATED] `run!` is deprecated, please use `execute` instead.
  task.run!

  #  BUG  FIXME WTF
  # It drove me crazy.  For the past hour I am trying to get the script to work.
  # I couldn't  do it without the sleep!!
  # WHY!
  sleep 10

  get '/' do
    "#{task.running?} : #{task.value}"
  end
  ```
# Benchmarking

  ```Bash
  ruby app.rb
  wrk -c300 -t10 -d30s http://0.0.0.0:4567/
  ```

# Even better?

Somebody makes a ruby function memoization gem with conccurent-ruby, please!

# Difference with Nginx stale

* Nginx

Pros:  Event-driven.  No update if no requests.

Cons:  While updating, one person will feel the lag.  Only one person.

* Concurrent-ruby

Pros:  Bring function caching with expiration with serving stale result while updating, to ANY ruby function.

Cons:  Re-calculation even if no requests.

# Best of two worlds?

Anyone wants to try.
