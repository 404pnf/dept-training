## 不会用flash/js视频播放器？别急，菜鸟也能播视频 5分钟

说实话，flash和js播放器真得很难。菜鸟在项目中都用过。如果现在再来一次，仍然觉得难。

有时候只是想让人家能看视频就行了。也不想装再写什么代码将视频文件内嵌到播放器代码中或者写js让播放自动捕捉到视频地址。

只想有个静态文件服务器，然后用户点视频链接就播放了。

这是可以做到的。甚至可以制定视频从哪个时间点开始播放。

我演示mp4是因为苹果操作系统上原生态不直接支持flv。用mp4演示方便。

如果你需要直接播放flv，那么用 http_flv_module即可。

1. ./configure --with-http_mp4_module
1.  ~/bin/nginx/sbin/nginx
1.  http://0.0.0.0:9999/test7.mp4
1.  http://0.0.0.0:9999/test7.mp4?start=10
1. ~/bin/nginx/sbin/nginx -s stop
