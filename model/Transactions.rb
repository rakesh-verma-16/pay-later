require 'sqlite3'
require_relative 'EntityHelper'

class Transactions
	def self.create(user_name, merchant_name, amount)
		
		query = "select outstanding,credit_limit from user where name=\"#{user_name}\";"
		result = EntityHelper.execute_command(query)

		current_outstanding = result[0][0]
		credit_limit = result[0][1]
		new_outstanding = current_outstanding + amount

		if (new_outstanding > credit_limit) 
			return "rejected! (reason: credit limit)"
		end

		insert_query = "insert into transactions values (null,\"#{user_name}\",\"#{merchant_name}\",#{amount});"
		EntityHelper.execute_command(insert_query)
		update_query = "UPDATE user SET outstanding=#{new_outstanding} where name=\"#{user_name}\";"
		EntityHelper.execute_command(update_query)
		return "success!"
	end
	
end