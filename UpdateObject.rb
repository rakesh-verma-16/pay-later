require_relative 'Classes/User'
require_relative 'Classes/Merchant'

if ARGV[0] == 'user'
	puts User.update_credit(ARGV[1], ARGV[2])
elsif ARGV[0] == 'merchant'
	puts Merchant.update_discount(ARGV[1], ARGV[2].gsub("%", ""))
else
	puts "Invalid arguments supplied"
end
