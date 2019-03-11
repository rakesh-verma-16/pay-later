require_relative 'Classes/User'
require_relative 'Classes/Merchant'
require_relative 'Classes/Transactions'

if ARGV[0] == 'user'
	puts User.create(ARGV[1], ARGV[2].to_s, ARGV[3].to_i)
elsif ARGV[0] == 'merchant'
	puts Merchant.create(ARGV[1], ARGV[2].gsub("%", ""))
else
	puts Transactions.create
end
