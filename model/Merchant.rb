require 'sqlite3'
require_relative 'EntityHelper'

class Merchant
	def self.create(merchant_name, email, discount)
		sql_string = "insert into merchant values (null,\"#{merchant_name}\",\"#{email}\",#{discount},#{discount});"
		EntityHelper.execute_command(sql_string)
		return "#{merchant_name}(#{discount})"
	end

	def self.update_discount(merchant_name, discount)
		query = "UPDATE merchant SET current_discount = #{discount},total_discount = total_discount + #{discount} where name = \"#{merchant_name}\";"
		EntityHelper.execute_command(query)
		return "#{merchant_name}(#{discount})"
	end

	def self.total_discount(merchant_name)
		query = "SELECT total_discount FROM merchant where name=\"#{merchant_name}\";"
		discount = EntityHelper.execute_command(query)
		return discount[0]
	end
	
end