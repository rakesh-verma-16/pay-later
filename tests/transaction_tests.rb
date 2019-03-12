require 'test/unit'
require 'sqlite3'
require_relative '../entities/User'
require_relative '../entities/Merchant'
require_relative '../entities/Transactions'

class TransactionTests < Test::Unit::TestCase

	@@user_details = {
		'name' => 'rakesh',
		'email' => 'rakesh@example.com',
		'credit_limit' => 400
	}

	@@merchant_details = {
		'name' => 'uber',
		'email' => 'uber@example.com',
		'discount' => 1.5
	}

	def setup
		super
		clear_db # Clears the DB completely
		# Creates User and Merchant before every test
		User.create(@@user_details['name'], @@user_details['email'], @@user_details['credit_limit'])
		Merchant.create(@@merchant_details['name'], @@merchant_details['email'], @@merchant_details['discount'])
	end

	# Test to check if transaction is successfully created in db
	# Tests the output "Success" and values in db
	def test_new_transaction_creation_success
		transaction_created = Transactions.create(@@user_details['name'], @@merchant_details['name'], 200)
		assert_equal("success!", transaction_created)
		query = "select amount from Transactions where user=\"#{@@user_details['name']}\" and merchant=\"#{@@merchant_details['name']}\";"
		result = Entities.execute_command(query)
		assert_equal(result[0][0], 200)
	end

	# Tests the failure response if transaction amount greater than credit limit
	# Assert equals to "rejected! (reason: credit limit)"
	def test_new_transaction_creation_fail
		transaction_created = Transactions.create(@@user_details['name'], @@merchant_details['name'], 500)
		assert_not_equal("success!", transaction_created)
		assert_equal("rejected! (reason: credit limit)", transaction_created)
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