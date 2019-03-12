require 'test/unit'
require 'sqlite3'
require_relative '../entities/User'
require_relative '../entities/Merchant'
require_relative '../entities/Transactions'


class AllTests < Test::Unit::TestCase

	def setup
		super
		db = SQLite3::Database.open "simpl.db"
		db.execute "DELETE FROM user;"
		db.execute "DELETE FROM merchant;"
		db.execute "DELETE FROM transactions;"
	end
	def test_new_user_creation
		username = 'rakesh'
		User.create(username, 'rakesh@example.com', 400)
		query = "select email, credit_limit from user where name=\"#{username}\";"
		result = Entities.execute_command(query)
		assert_equal(result[0][1], 400)
		assert_equal(result[0][0], 'rakesh@example.com')
	end

	def test_new_merchant_creation
		mname = 'uber'
		Merchant.create(mname, 'uber@example.com', 2.5)
		query = "select email, current_discount, total_discount from merchant where name=\"#{mname}\";"
		result = Entities.execute_command(query)
		assert_equal(result[0][1], 2.5)
		assert_equal(result[0][2], 2.5)
		assert_equal(result[0][0], 'uber@example.com')
	end

	def test_new_transaction_creation_success
		username = 'rakesh'
		mname = 'uber'
		transaction_created = Transactions.create(username, mname, 200)
		assert_equal("success!", transaction_created)
		query = "select amount from Transactions where user=\"#{username}\" and merchant=\"#{mname}\";"
		result = Entities.execute_command(query)
		assert_equal(result[0][0], 200)
	end


	def test_new_transaction_creation_fails
		username = 'rakesh'
		mname = 'uber'
		Transactions.create(username, mname, 2000)
		query = "select email, credit_limit from user where name=\"#{username}\";"
		assert_equal("rejected! (reason: credit limit)", transaction_created)
	end


end