require 'test/unit'
require 'sqlite3'
require_relative '../model/User'
require_relative '../model/Merchant'
require_relative '../model/Transactions'


class UserTests < Test::Unit::TestCase

	@@user_details = {
		'name' => 'rakesh',
		'email' => 'rakesh@example.com',
		'credit_limit' => 400
	}

	@@user_details2 = {
		'name' => 'verma',
		'email' => 'verma@example.com',
		'credit_limit' => 300
	}

	def setup
		super
		clear_db # Clears the DB completely
	end


	# Tests new user creation
	# Calls unit method to create entry
	# Queries database
	# Compares both the entries and evaluates true if both are identical
	def test_new_user_creation
		User.create(@@user_details['name'], @@user_details['email'], @@user_details['credit_limit'])
		query = "select email, credit_limit from user where name=\"#{@@user_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][1], 400)
		assert_equal(result[0][0], 'rakesh@example.com')
	end


	# Test the updatation of user's credit limit
	# Initially it was set to 400
	# Verified with a test `assert_equal(result[0][0], 400)`
	# Later updated to 500 and verified again `assert_equal(result[0][0], 500)`
	def test_user_update_credit_limit
		User.create(@@user_details['name'], @@user_details['email'], @@user_details['credit_limit'])
		query = "select credit_limit from user where name=\"#{@@user_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 400)
		
		new_credit_limit = 500
		User.update_credit(@@user_details['name'], new_credit_limit)
		query = "select credit_limit from user where name=\"#{@@user_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 500)
	end

	# Tests the unit method User.payback
	# Sets the outstanding amount to 200
	# Verifies that amount has been set to 200
	# Pays back 150
	# Verifies that the remaining amount is 50 (200 - 150 = 50)
	def test_user_payback
		create_user_with_pending_dues(200, @@user_details)

		query = "select outstanding from user where name=\"#{@@user_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 200)

		User.payback(@@user_details['name'], 150)
		query = "select outstanding from user where name=\"#{@@user_details['name']}\";"
		result = EntityHelper.execute_command(query)
		assert_equal(result[0][0], 50)
	end


	# Tests the User.dues method to return pending dues for a particular user
	# Sets the dues to 200
	# Queries to check if the amount is same in db
	def test_pending_dues
		create_user_with_pending_dues(200, @@user_details)

		pending_dues = User.dues(@@user_details['name'])
		assert_equal(pending_dues, 200)
	end


	# Gets the users at credit limit
	# Creates 2 users with limit 400 and 300
	# Sets the pending dues to 300
	# User.defaulters returns one name only for which the limit is 300
	def test_users_at_credit_limit
		create_user_with_pending_dues(300, @@user_details)
		create_user_with_pending_dues(300, @@user_details2)

		user_at_credit_limit = User.defaulters

		assert_equal([@@user_details2['name']], user_at_credit_limit)
	end

	private

	# Clears the DB completely
	def clear_db
		db = SQLite3::Database.open "simpl.db"
		db.execute "DELETE FROM user;"
		db.execute "DELETE FROM merchant;"
		db.execute "DELETE FROM transactions;"
	end

	def create_user_with_pending_dues(outstanding_amount = 200, user_details = @@user_details)
		User.create(user_details['name'], user_details['email'], user_details['credit_limit'])
		query = "UPDATE user SET outstanding = #{outstanding_amount} where name = \"#{user_details['name']}\";"
		EntityHelper.execute_command(query)
	end
end