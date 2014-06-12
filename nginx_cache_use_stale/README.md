
## 演示 nginx proxy_cache 中的 use stale 功能

1. 讲解后台sinatra，计数，计算到达后台的请求数
1. 演示后台计数和refresh功能，启动 ruby app.rb
1. 压力工具
   wrk -c1 -t1 -d60s http://0.0.0.0:8000/
   wrk -c300 -t10 -d60s http://0.0.0.0:8000/
1. 情况： 无缓存， 有缓存， 有缓存，有use_stale 和 lock
1. 记录结果，分析结果

## nginx 配置

1. 启动  nginx -c ~/github/dept-training/nginx_cache_use_stale/conf/nginx.conf

2. 配置文件 

  
  server {
        listen       8081;

        location / {
            proxy_pass http://0.0.0.0:4567;
            #proxy_cache one;
            #proxy_cache_valid 200 1s;
            #proxy_cache_lock on ;
            #proxy_cache_use_stale error timeout updating;
        }
    }