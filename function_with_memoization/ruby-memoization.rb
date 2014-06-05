
# https://github.com/djberg96/memoize


# module Memo
#   @@memo ||= {}

#   def self.method_missing(name, *args, &block)
#     raise ArgumentError unless block_given? && args.empty?

#     @@memo[name] = Hash.new do |h, k|
#       h[k] = block.call(*k)
#     end

#     define_singleton_method(name) do |*a|
#       @@memo[name][a]
#     end unless method_defined? name
#   end
# end

# https://github.com/neilk/persistent_memoize
# 可将计算缓存到文件

require 'memoize'

include Memoize

def f
  sleep 3
  'f: done'
end

def g(n)
  sleep n
  'g: done'
end

def fib n
  if n < 2
    1
  else
    fib(n - 1) + fib(n - 2)
  end
end

# fib 10
# fib 50
# memoize :fib
# fib 50
# fib 100

require 'memmo'

$m = Memmo.new
$m.register(:f, ttl: 10) { sleep 3; 'ok' }

$m # 查看下 $m

$m[:f] # 会很快， 10秒后，会重新计算，很慢
# 等10秒
$m[:f]