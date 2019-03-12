require_relative '../model/User'
require_relative '../model/Merchant'
require_relative '../model/Transactions'


command = ARGV[0]
result = if command == 'user'
		User.create(ARGV[1], ARGV[2].to_s, ARGV[3].to_i)
	elsif command == 'merchant'
		Merchant.create(ARGV[1], ARGV[2],ARGV[3].gsub("%", "").to_f)
	elsif command == 'txn'
		Transactions.create(ARGV[1], ARGV[2], ARGV[3].to_f)
	else
		'Invalid Command'
	end

puts result
