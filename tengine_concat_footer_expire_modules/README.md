
## 编译和安装tengine

1. 已经编译好了。就是本目录的那个nginx执行文件
2. ./nginx -V 检查安装地址和模块

    configure arguments: --prefix=/Users/bai/opt/tengine --with-http_concat_module

    我们发现 http_concat 不是默认安装的

2. 启动 ./nginx  不加任何参数，
## 两行nginx配置文件，让站点得分增加20分！ 10分钟

### 介绍yslow

1. yahoo工程师对优化性能提出的建议
2. 书： 构建高性能网站？封面是一只猎狗。
3. yslow在线文档和书的内容基本一样。
3. 浏览器插件

### 演示

1. 安装yslow插件
2. 启动后台程序 ruby app.rb
3. 使用前 http://0.0.0.0:8000/yslow.html 得分为76，等级是C
4. 使用后 http://0.0.0.0:8000/yslow.html

### 将css串联起来，减少http请求
concat module

1. <http://tengine.taobao.org/document/http_concat.html>
1. 演示concat模块可以串联css
2. 演示nginx配置文件中可能出现的错误，先将 / proxy_pass给后台，再写concat规则，造成css不会串联
3. 演示css会按照你写的顺序加载。交换green.css和red.css顺序
4. 用yslow查看是否生效

### 给可以让用户缓存的元素设置缓存时间，减少http请求

1. 服务器缓存规则 参考yslow文档
2. yslow查看是否生效
3. tengine的header模块就是nginx的第三方模同名模块，是nginx内置的header模块的加强版，。<http://tengine.taobao.org/document/http_headers.html>

## 学会了别去害人：强制在网页中插广告 5分钟

### 模块

- tengine footer 
- <http://tengine.taobao.org/document/http_footer_filter.html>

此模块是taobao集成在tengine中的模块。nginx中对应的是更通用的sub模块。footer可以理解为一个简化了配置但同时也减少了灵活性的sub模块。

### 演示

1. 演示footer作用 访问 '/' 因为只添在nginx代理的页面添加，静态文件我设定了root，直接去访问了
2. 给所有代理站点加统计js

### 应用场景：

1. 网络服务商强插广告和垃圾代码
2. 系统管理员添加统计代码
