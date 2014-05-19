
## 启动和关闭nginx
./nginx -s stop
sh start_*.sh

## concat module
1. 演示concat模块可以串联css
2. 演示nginx配置文件中可能出现的错误，先将 / proxy_pass给后台，再写concat规则，造成css不会串联
3. 演示css会按照你写的顺序加载。交换green.css和red.css顺序

## footer module
1. 演示footer作用 访问 '/' 因为只添在nginx代理的页面添加，静态文件我设定了root，直接去访问了
2. 给所有代理站点加统计js

## header module
1. 规则
2. yslow报告对比
