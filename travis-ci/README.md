
从菜鸟到普通程序员之： github和travis-ci让自动测试


# 产品平台
<https://github.com/travis-ci/travis-ci>

# 免费版
Travis CI is a hosted continuous integration and deployment system. There are two versions of it, travis-ci.com for private repositories, and travis-ci.org for public repositories.

# 单元测试是系统集成的根？

1. 个人理解系统集成起步阶段就是单元测试
2. 静态语言编译是否成功实际也是一种很基础的测试。如果都不编译建就不能运行，不能运行就不能测试。但能编译不代表集成测试了。
3. 动态语言无需编译。

# 演示
只是快速演示travis ci能在github提交后执行用户定制的动作，如跑单元测试。

1. 已经让travis ci关注的项目
https://github.com/404pnf/kidslib-nanhai-sso
2. 专门为培训写的一个项目并配了单元测试的（此项目会在单元测试中单讲），现场添加到travis ci中
https://github.com/404pnf/dept-training-unit-test-exmaple-gongwen-shenpi

# 同一个库多个分支支持自动测试
1. 创建一个新分支然后故意出错，看travis-结果
https://github.com/404pnf/dept-training-unit-test-exmaple-gongwen-shenpi

# 代码晴雨表小图标
1. 将travis最近一次的运行结果显示在代码库的readme文件中。一眼就知道当前各个状态

# github多人多库合作时自动测试
无法演示

# 甚至可以没有本地测试环境仍得到测试结果
演示直接用浏览器在github提交代码。

因此开发人员甚至不需要有本地的测试环境，甚至不需要开发环境（但几乎不会没有本地开发环境）。但如果你正好在海边度假呢，灵感乍现，用ipad写写代码 ：）

# 收费版
129美元/每月起。支持私有库等更多功能。

# 介绍文章
Travis CI会替代Jenkins吗
<http://larrycaiyu.com/2012/03/06/travis-ci-is-evolution.html>
