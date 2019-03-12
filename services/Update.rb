require_relative '../entities/User'
require_relative '../entities/Merchant'

if ARGV[0] == 'user'
	puts User.update_credit(ARGV[1], ARGV[2])
elsif ARGV[0] == 'merchant'
	puts Merchant.update_discount(ARGV[1], ARGV[2].gsub("%", "").to_f)
else
	puts "Invalid arguments supplied"
end
