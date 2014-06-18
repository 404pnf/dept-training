# http://opkeep.com/system/linux/nginx-gray.html

# <style type="text/css">html {filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); }</style>
# 就可以实现在IE及IE内核浏览器下，所有网站变灰色。步骤如下：


# 在nginx.conf配置文件的http {…}大括号内增加以下两行：

# sub_filter  '</head>'  '<style type="text/css">html {filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); }</style></head>';
# sub_filter_once on;

# offical doc

# http://nginx.org/en/docs/http/ngx_http_sub_module.html


require 'sinatra'

get '/' do
  "from sinatra with love<br>"
end

