require_relative 'Classes/User'
require_relative 'Classes/Merchant'

result = case ARGV[0]
when 'discount'
	Merchant.total_discount(ARGV[1])
when 'dues'
	User.dues(ARGV[1])
when 'users-at-credit-limit'
	User.defaulters
when 'total-dues'
	User.index_dues
else
	"Invalid statement"
end

puts result