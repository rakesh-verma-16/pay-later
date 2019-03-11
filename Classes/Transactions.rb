require 'sqlite3'
class Transactions
	def self.create
		user_name = ARGV[1]
		merchant_name = ARGV[2].to_s
		amount = ARGV[3].to_i
		db = SQLite3::Database.open 'simpl.db'
		result = db.execute "select outstanding,credit_limit from user where name=\"#{user_name}\";"
		current_outstanding = result[0][0]
		credit_limit = result[0][1]
		new_outstanding = current_outstanding + amount
		if (new_outstanding > credit_limit) 
			return "rejected! (reason: credit limit)"
		end
		sql_string = "insert into transactions values (null,\"#{user_name}\",\"#{merchant_name}\",#{amount});"
		db.execute sql_string
		sql_string = "UPDATE user SET outstanding=#{new_outstanding} where name=\"#{user_name}\";"
		db.execute sql_string
		return "success!"
	end
end