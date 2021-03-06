require 'sqlite3'
require_relative 'EntityHelper'

class User
	def self.create(username, email, credit_limit)
		query = "insert into user values (null,\"#{username}\",\"#{email}\",#{credit_limit},0);"
		EntityHelper.execute_command(query)

		return "#{username}(#{credit_limit})"
	end


	def self.update_credit(username, credit_limit)

		query = "UPDATE user SET credit_limit=#{credit_limit} where name=\"#{username}\";"
		EntityHelper.execute_command(query)

		return "#{username}(#{credit_limit})"
	end

	def self.payback(username, amount)
		if (amount < 0)
			raise IOError.new "Amount can not be negative"
		end
		query = "UPDATE user SET outstanding = outstanding-#{amount} where name = \"#{username}\";"
		EntityHelper.execute_command(query)

		pending_dues_query = "SELECT outstanding FROM user where name = \"#{username}\";"
		pending_dues = EntityHelper.execute_command(pending_dues_query)
		
		return "#{username}(dues: #{pending_dues[0][0]})"
	end

	def self.dues(username)
		query = "SELECT outstanding from user where name = \"#{username}\";"
		result = EntityHelper.execute_command(query)
		return result[0][0]
	end

	def self.index_dues
		result = []
		total = 0
		query = "SELECT name,outstanding from user"
		EntityHelper.execute_command(query).each do |list|
			result << "#{list[0]}: #{list[1]}"
			total += list[1]
		end
		result << "total: #{total}"
		return result;
	end

	def self.defaulters
		query = "SELECT name from user where outstanding=credit_limit;"
		result = EntityHelper.execute_command(query)
		return result[0]
	end
end