require 'pp'
require 'json'
require 'SecureRandom'
require_relative 'article.rb'

# Student类： 字段有： telephone, name, password, school, articles uuid
# 其中telephone和uuid字段各自都应该是唯一标示
# uuid是机器生成的用户唯一标示，为了不暴露学生真实信息，该字段对外只读
class Student

  def initialize(telephone, name: 'john', password: '', school: 'bfsu')
    @telephone = telephone
    @uuid = SecureRandom.uuid # 如果还是觉得不保险，可以求telephone加name加password的摘要值
  end

  def save_article(article)
    type = "article_#{article.type}"
    r = instance_variable_get("@#{type}")
    if r
      instance_variable_set("@#{type}", r.unshift(article))
    else
      instance_variable_set("@#{type}", [article])
    end
  end

  def article(t)
    type = "article_#{t}"
    instance_variable_get("@#{type}")[0]
  end

  def all_articles(t)
    type = "article_#{t}"
    instance_variable_get(:"@article_#{type}")

    instance_variable_get("@#{type}")
  end

  def article_types
    instance_variables.grep(/article/) # get all instance_variables
  end

end


stu1 = Student.new '13800138000'
stu1.save_article(Article.new 'a', 'type a', 'draft 1')
stu1.save_article(Article.new 'a', 'type a', 'draft 2')
stu1.save_article(Article.new 'b', 'type b', 'draft 3')
stu1.save_article(Article.new 'b', 'type b', 'draft 4')
pp stu1.to_json
pp stu1.article('a').to_json
p stu1.article('b').to_json
p stu1.all_articles('a')
p stu1.article_types