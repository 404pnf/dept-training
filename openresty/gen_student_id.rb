require 'csv'
# ==> true
require 'securerandom'
# ==> true
name = -> { SecureRandom.uuid }
# ==> #<Proc:0x007f906a88f7a0@(irb):3 (lambda)>
age = -> { (1..100).to_a.sample }
# ==> #<Proc:0x007f906a8ddbf8@(irb):4 (lambda)>
gender = -> { ['f', 'm'].sample }
# ==> #<Proc:0x007f906a90eff0@(irb):5 (lambda)>

csv = 100000.times.reduce([['name', 'age', 'gender']]) { |a, e| a << [name.call, age.call, gender.call] }.map { |e| e.to_csv(force_quotes: true) }
# =Execution timed out.

File.write('student_db.csv', csv.join())
