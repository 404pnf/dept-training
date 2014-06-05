require 'sinatra'
require 'concurrent'

# configure { set :server, :puma } # much faster than webrick
# ruby app.rb -s Puma

def f
  sleep 4 # slow query in db
  Time.now
end

#  FIXME
# wating for someone to include this function into a memoization gem
task = Concurrent::TimerTask.new(execution_interval: 5, timeout_interval: 5) { f }

#  FIXME
# name collition with sinatra run!
# sinatra warning: [DEPRECATED] `run!` is deprecated, please use `execute` instead.
task.run!
#  BUG WTF FIXME
# It drove me crazy.  For the past hour I am trying to get the script to work.
# I couldn't without the sleep!!
# WHY!
sleep 10

get '/' do
  "#{task.running?} : #{task.value}"
end
