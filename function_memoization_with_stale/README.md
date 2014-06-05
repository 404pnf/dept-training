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

1. cache the result with function memoization.

<https://github.com/search?q=ruby+memo&type=Repositories&ref=searchresults>

Not good enough. Because no cache expiration support.

2. number 1 with expiration support

<https://github.com/educabilia/memmo>

Not good enough. Because

  1. Doesn't support functions take arguments (easier to fix).
  1. Doesn't prevent re-calculation while calculating the result.
  1. While updating cache, more requests coming for result. Because there is no result available, all requests going to backend, eating more resources, making it even more slower to get the result, making even more requests going to backend

3. number 2 with support for servering stale result while updating cache

   1. use Nginx proxy_cache_with_stale

Not good enough. Because function need to expose their result over http to make it work.

# concurrent-ruby comes to resue?

  ```Ruby
  require 'sinatra'
  require 'concurrent'

  def f
    sleep 4 # slow query in db
    Time.now
  end

  #  FIXME
  # wating for someone to include this function into a memoization gem
  task = Concurrent::TimerTask.new(execution_interval: 5, timeout_interval: 5) { f }

  #  FIXME
  # name collition with sinatra run!
  # sinatra warning: [DEPRECATED] `run!` is deprecated, please use `execute` instead.
  task.run!

  #  BUG WTF FIXME
  # It drove me crazy.  For the past hour I am trying to get the script to work.
  # I couldn't without the sleep!!
  # WHY!
  sleep 10

  get '/' do
    "#{task.running?} : #{task.value}"
  end
  ```
# Benchmark

  ```Bash
  ruby app.rb
  wrk -c300 -t10 -d30s http://0.0.0.0:4567/
  ```

# Even better?

Somebody make a ruby function memoization gem with conccurent-ruby, please!

# Difference with Nginx stale

* Nginx

Pros:  Event-driven.  No update if no requests.

Cons:  While updating, one person will feel the lag.  Only one person.

* Concurrent-ruby

Pros:  Bring function caching with expiration with serving stale result wiile updating to any ruby function.

Cons:  Re-calculation even if no requests.

# Best of two worlds?

Anyone wants to try.


