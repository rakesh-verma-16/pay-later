require_relative '../entities/User'

username = ARGV[0]
amount = ARGV[1]
result = User.payback(username, amount.to_f)
puts result