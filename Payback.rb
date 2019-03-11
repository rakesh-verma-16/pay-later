require_relative 'Classes/User'

username = ARGV[0]
amount = ARGV[1]
User.payback(username, amount.to_i)