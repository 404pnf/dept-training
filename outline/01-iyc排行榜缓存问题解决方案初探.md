# iyc排行榜缓存问题解决方案初探

## 演示 nginx proxy_cache 中的 use stale 功能

1. 讲解后台sinatra，计数，计算到达后台的请求数
2. 演示后台计数和refresh功能，启动 ruby app.rb
3. 压力工具
   wrk -c1 -t1 -d30s http://0.0.0.0:8000/
   wrk -c300 -t10 -d30s http://0.0.0.0:8000/
4. 情况： 无缓存， 有缓存， 有缓存，有use_stale 和 lock
5. 记录结果，分析结果


## 有了理论和实际运行结果后我们简单写些代码改善爱洋葱

## 目的： 解决特定的性能问题

1. 用siantra写个mysql代理
直接用mysql2这个gem写sql查询语句把结果转为json通过http返回。

1. 用nginx的proxy_cache缓存sinatra的http返回结果
要用的是 proxy_cache_stale

1. 可以让nginx跑在55555端口，这样80仍可以用apache

## 性能问题的实质

1. 之前缓存的问题都是失效后，来了很多请求，每个请求都需要10秒才能返回答案，那么10秒当中来10000个请求，就等于去后台计算10000次，每次都至少需要10秒。越去计算，越慢，越慢，就会有越多的请求去。

1. 代理mysql请求，将结果存在nginx的cache中，并启用 use_stale。当缓存失效的时候，同时来来了1000个请求，只有一个请求去后台，其它999个直接给它过期的结果，当去后台的结果回来后，再来的所有请求都用新结果。同一时间内只会有一个用户被阻塞，感觉到网站慢。

## 操作步骤

1. 服务器上克隆这个库
1. 服务器上安ruby呗 rvm
1. 安 gem install bundle 呗
1. 在克隆的文件夹 bundle install 安装依赖呗
1. ruby server.rb 呗
1. 运行在 4567 端口了
1. 其它就是nginx的反向代理的事情了

## 教学演示步骤

1. 登陆 ssh tufu
1. 进入 ~/dept-training 中相应目录
1. 启动程序
1. 本地浏览器访问 server-ip:port
1. 应该看到json结果
1. nginx那部分不在本次演示范内，因为已经有单独的演示了

