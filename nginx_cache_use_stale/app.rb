require 'sinatra'

mk_db = -> n {
           -> msg {
            case msg
            when :reset
              n = 0
            when :val
              n = n + 1
              n
            when :view
              n
            else
              :no_understand_sir
            end
          }
      }

db = mk_db.call 0

get '/' do
  #sleep 10
  "#{db.call :val}\n"
end

get '/refresh' do
  db.call :reset
  "reset counter to #{db.call :view}\n"
end

get '/current' do
  "current value is #{db.call :view}\n"
end


get '/*' do
  "<a href='/'>/</a> <br> <a href='/refresh'>/refresh</a> <p> restrcted: area 51</p>"
end


