#!/usr/bin/env ruby
require 'sqlite3'

class EntityHelper
	def self.create_table(dbname = "simpl.db")
    
		db = SQLite3::Database.new dbname

		db.execute "DROP TABLE IF EXISTS user"
		db.execute "DROP TABLE IF EXISTS merchant"
		db.execute "DROP TABLE IF EXISTS transactions"
		db.execute <<-SQL
  			CREATE TABLE user (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				name TEXT NOT NULL,
  				email TEXT NOT NULL UNIQUE,
  				credit_limit INT NOT NULL,
  				outstanding REAL DEFAULT 0
  			);
    SQL

    db.execute <<-SQL
  			CREATE TABLE merchant (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				name TEXT NOT NULL UNIQUE ,
          email TEXT UNI,
  				current_discount REAL NOT NULL,
  				total_discount REAL DEFAULT 0
  			);
    SQL
    
    db.execute <<-SQL
  			CREATE TABLE transactions (
  				id INTEGER PRIMARY KEY AUTOINCREMENT,
  				user INT NOT NULL,
  				merchant TEXT NOT NULL,
  				amount REAL NOT NULL
  			);  		
		SQL
	end

  def self.execute_command(query)
    db = SQLite3::Database.open "simpl.db"
    db.execute query
  end
end
