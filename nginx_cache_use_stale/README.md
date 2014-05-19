
## 演示 nginx proxy_cache 中的 use stale 功能

1. 讲解后台sinatra，计数，计算到达后台的请求数
2. 演示后台计数和refresh功能，启动 ruby app.rb
3. 压力工具
   wrk -c1 -t1 -d30s http://0.0.0.0:8000/
   wrk -c300 -t10 -d30s http://0.0.0.0:8000/
4. 情况： 无缓存， 有缓存， 有缓存，有use_stale 和 lock
5. 记录结果，分析结果
