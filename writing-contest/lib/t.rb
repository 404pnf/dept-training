require 'aversion'
require 'pp'
class Person
  include Aversion

  def initialize(hunger)
    @hunger = hunger
  end

  def eat
    transform do
      @hunger -= 5
    end
  end
end

j = Person.new 1000
nj = j.eat
nnj = j.eat
pp j