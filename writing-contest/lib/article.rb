require 'set'
require 'pp'
require 'json'

# Article类
# 字段有 title, content, timestamp
# timestamp对外只读
class Article
  #  FIXME, avoid class variable
  @@class_type = Set.new

  attr_reader :type

  def initialize(type, title, content)
    @@class_type << type
    @type, @title, @content, @timestamp = type, title, content, Time.now
  end

  def self.types
    @@class_type
  end
end

a1 = Article.new(:type_a, 'title 1' , 'content la')
a2 = Article.new(:type_b, 'title 1' , 'content la')

pp Article.types
pp a1
pp a2
pp a1.to_json