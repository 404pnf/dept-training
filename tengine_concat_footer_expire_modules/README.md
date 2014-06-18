
## 编译和安装tengine

1. 已经编译好了。并把执行文件直接复制到本目录下
1. ./nginx -V 检查安装地址和模块

        configure arguments: --prefix=/Users/bai/opt/tengine --with-http_concat_module
    
        我们发现 http_concat 不是默认安装的

1. 启动 ./nginx
1. 停止 ./nginx -s stop
1. 坑爹啊坑爹啊。如果要在命令行指定配置文件，需要用绝对路径

        ./nginx -c conf/nginx.conf
        ./nginx -c ./conf/nginx.conf
        # 上面这行实际去了编译时 --prefix目录下的 conf/ 
        # 加点表示当前目录也没用
    
        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/nginx
        # 绝对路径才可以

## 几行nginx配置文件，让站点性能上一个档次！ 10分钟

### 介绍yslow

1. yahoo工程师对优化性能提出的建议
2. 书： 构建高性能网站？封面是一只猎狗。
3. yslow在线文档和书的内容基本一样。
3. 浏览器插件

### 演示

1. 安装yslow插件
3. 没有添加神奇的3行代码时启动nginx 
        
        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/yslow-before.conf
4.  http://0.0.0.0:8000/yslow.html 查看得分

    1. Grade版面查看得分为75，等级是C
    1. Statistics版面查看 
         - 浏览器空缓存时51个http请求，传输8526K数据
         - 浏览器满缓存时51个http请求，传输2881.3K数据
    
5. 停止nginx  ./nginx -s stop
6. 清空chrome缓存
6. 添加了神奇的3行配置代码

        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/yslow-after.conf

7. 使用后 http://0.0.0.0:8000/yslow.html 查看得分
 
     1. Grade版面 得分82，等级是B
     1. Statistics版面查看 
         - 浏览器空缓存时51个http请求，传输8526K数据
         - 浏览器满缓存时1个http请求，传输0.5k数据


### 将css串联起来，减少http请求


1. ngx_http_concat_module <http://tengine.taobao.org/document_cn/http_concat_cn.html>
1. 通过 nginx -V 得知这个模块需要在编译的时候制定启用

         --with-http_concat_module

1. 启动 nginx

        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/concat.conf

1. 查看 public/concat.html 文件，可以看它是这样链接css的

           <link rel="stylesheet" href="/css/??green.css,red.css" />  
      
1. 访问 http://0.0.0.0:8000/concat.html
1. 通过浏览器 inspect element 功能查看css确实串联在一期了
1. 演示css会按照你写的顺序加载。交换green.css和red.css顺序。编辑 concat.html 

1. 演示nginx配置文件中可能出现的错误，先将 / proxy_pass给后台，再写concat规则，造成css不会串联

1. 用yslow查看是否生效

### 给可以让用户缓存的元素设置缓存时间，减少http请求

1. 服务器缓存规则 参考yslow文档
2. yslow查看是否生效
3. tengine的header模块就是nginx的第三方模同名模块，是nginx内置的header模块的加强版，。<http://tengine.taobao.org/document/http_headers.html>

## 学会了别去害人：强制在网页中插广告 5分钟

### 模块

- ngx_http_footer_filter_module <http://tengine.taobao.org/document_cn/http_footer_filter_cn.html>

此模块是taobao集成在tengine中的模块。nginx中对应的是更通用的sub模块。footer可以理解为一个简化了配置但同时也减少了灵活性的sub模块。

### 演示


1. 查看后台程序源码并启动

         ruby app.rb
1. 不配置footer模块启动nginx

        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/footer.conf

1. 配置footer模块

        ./nginx -s stop
        vim conf/footer.conf
        ./nginx -c /Users/bai/github/dept-training/tengine_concat_footer_expire_modules/conf/footer.conf

1. 演示footer作用 访问 '/' 会多出我们添加的字符

1. 推论

    - 我们可以用这个功能给所有代理的网站强加上广告，如果我们是电信公司或者狗屁网络服务商的话
    - 公司内所有代理站点加统计js。这样无需让每个站点都一一去添加统计代码
    
    
1. 使用中常见错误

    - 只能给反向代理的站点使用，因为实际工作原理是读入了后台的内容（可为动态也可以是静态，但必须从后台来，不是反向代理本身能访问的静态文件），进行了修改，然后返回给浏览器
    - 如果是方向代理能访问的静态文件，不起作用。原因应该是这种情况下nginx采用直接发送到网卡的方式，不会经过


### 应用场景：

1. 网络服务商强插广告和垃圾代码
2. 系统管理员添加统计代码

## 个人吐槽tengine
### dso

### taobao
- 姚伟斌 <https://github.com/yaoweibin>
- chaoslawful<https://github.com/chaoslawful>

### independent 
- agentzh <https://github.com/agentzh> ______ 赞一个  ____ 代码好，文章写得清楚
- <https://github.com/openresty/nginx-tutorials/tree/master/zh-cn>

### openresty
<https://github.com/openresty/ngx_openresty> __  32个赞

可惜这回一直没装上libdrizzle。遥想3年前。。。。