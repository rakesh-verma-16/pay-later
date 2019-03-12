require 'sqlite3'
require_relative '../model/Entities'

class Transactions
	def self.create(user_name, merchant_name, amount)
		
		query = "select outstanding,credit_limit from user where name=\"#{user_name}\";"
		result = Entities.execute_command(query)

		current_outstanding = result[0][0]
		credit_limit = result[0][1]
		new_outstanding = current_outstanding + amount

		if (new_outstanding > credit_limit) 
			return "rejected! (reason: credit limit)"
		end

		insert_query = "insert into transactions values (null,\"#{user_name}\",\"#{merchant_name}\",#{amount});"
		Entities.execute_command(insert_query)
		update_query = "UPDATE user SET outstanding=#{new_outstanding} where name=\"#{user_name}\";"
		Entities.execute_command(update_query)
		return "success!"
	end
	
end