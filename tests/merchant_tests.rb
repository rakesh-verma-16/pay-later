require 'test/unit'
require 'sqlite3'
require_relative '../model/User'
require_relative '../model/Merchant'
require_relative '../model/Transactions'

class MerchantTests < Test::Unit::TestCase

	@@merchant_details = {
		'name' => 'uber',
		'email' => 'uber@example.com',
		'discount' => 1.5
	}

	def setup
		super
		clear_db # Clears the DB completely
	end

	# Tests the creation of new merchant
	def test_new_merchant_creation
		puts "--Running the merchant creation test--\n"
		Merchant.create(@@merchant_details['name'], @@merchant_details['email'], @@merchant_details['discount'])
		query = "select email, current_discount, total_discount from merchant where name=\"#{@@merchant_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][1], 1.5)
		assert_equal(result[0][2], 1.5)
		assert_equal(result[0][0], 'uber@example.com')
	end

	# Tests the merchant update discount code
	def test_merchant_update_discount
		puts "--Running the merchant discount update test--\n"
		Merchant.create(@@merchant_details['name'], @@merchant_details['email'], @@merchant_details['discount'])
		updated_discount = 3
		Merchant.update_discount(@@merchant_details['name'], updated_discount)
		query = "select current_discount from merchant where name=\"#{@@merchant_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 3)

	end

	# Tests the total discount method.
	# Initially discount offered was 1.5, updated it to 3 and checked if total was 4.5
	def test_total_merchant_discount
		puts "--Running the test to fetch total discount from a merchant--\n"
		Merchant.create(@@merchant_details['name'], @@merchant_details['email'], @@merchant_details['discount'])
		updated_discount = 3
		Merchant.update_discount(@@merchant_details['name'], updated_discount)
		query = "select total_discount from merchant where name=\"#{@@merchant_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 4.5)
	end


	private

	# Clears the DB completely
	def clear_db
		db = SQLite3::Database.open "simpl.db"
		db.execute "DELETE FROM user;"
		db.execute "DELETE FROM merchant;"
		db.execute "DELETE FROM transactions;"
	end
end