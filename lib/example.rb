require 'rubygems'
require 'active_record'
require 'tiny_tds'
require 'activerecord-sqlserver-adapter'




# Connect to Microsoft SQL Server 2012 and early versions
ActiveRecord::Base.establish_connection(
	:adapter => 'sqlserver',
	:mode => 'odbc',
	:dsn => 'your-dsn-name',
	:username => 'db-user-name',
	:password => 'db-user-password'
)

# 	Table: Users
# 		=> ID (pk)
# 		=> first_name
# 		=> last_name
#
class User < ActiveRecord::Base
	self.table_name = "Users"
	self.primary_key = "ID"
end


# Test some activerecord methods
puts "Total count: #{User.all.count}"
puts "Find record by primary key:  #{User.find(1)}"
