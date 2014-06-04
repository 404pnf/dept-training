# 目的： 解决特定的性能问题

1. 用siantra写个mysql代理
直接用mysql2这个gem写sql查询语句把结果转为json通过http返回。

1. 用nginx的proxy_cache缓存sinatra的http返回结果
要用的是 proxy_cache_stale

1. 可以让nginx跑在55555端口，这样80仍可以用apache

# 性能问题的实质

1. 之前缓存的问题都是失效后，来了很多请求，每个请求都需要10秒才能返回答案，那么10秒当中来10000个请求，就等于去后台计算10000次，越去计算，越慢，越慢，就会有越多的请求去

1. 代理mysql请求并将结果存在nginx的cache中，并启用 use_stale，当缓存失效的时候，同时来来了1000个请求，只有一个请求去后台，其它999个直接给它过期的结果，当去后台的结果回来后，再来的所有请求都用新结果

# 操作步骤

1. 服务器上克隆这个库
1. 服务器上按ruby呗 rvm
1. 安 gen install bundle 呗
1. 在克隆的文件夹 bundle install 安装依赖呗
1. ruby server.rb 呗
1. 运行在 4567 端口了
1. 其它就是nginx的反向代理的事情了

# 教学演示步骤

1. 登陆47. ssh tufu
1. 进入 ~/dept-training 中相应目录
1. 启动程序
1. 本地浏览器访问 server-ip:port
1. 应该看到json结果
1. nginx那部分不在本次演示范内，因为已经有单独的演示了
