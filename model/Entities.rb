#!/usr/bin/env ruby
require 'sqlite3'

class Entities
	def self.create_table
		db = SQLite3::Database.new 'simpl.db'

		db.execute "DROP TABLE IF EXISTS user"
		db.execute "DROP TABLE IF EXISTS merchant"
		db.execute "DROP TABLE IF EXISTS transactions"
		db.execute <<-SQL
  			CREATE TABLE user (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				name TEXT NOT NULL,
  				email TEXT NOT NULL,
  				credit_limit INT NOT NULL,
  				outstanding INT DEFAULT 0
  			);
    SQL

    db.execute <<-SQL
  			CREATE TABLE merchant (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				name TEXT NOT NULL,
  				current_discount INT NOT NULL,
  				total_discount INT DEFAULT 0
  			);
    SQL
    
    db.execute <<-SQL
  			CREATE TABLE transactions (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				user INT NOT NULL,
  				merchant TEXT NOT NULL,
  				amount INT NOT NULL
  			);  		
		SQL
	end

  def self.execute_command(query)
    db = SQLite3::Database.open 'simpl.db'
    db.execute query
  end
end
