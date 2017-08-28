require 'rubygems'
require 'active_record'
require 'tiny_tds'
require 'activerecord-sqlserver-adapter'




# Connect to Microsoft SQL Server 2016 and later versions
ActiveRecord::Base.establish_connection(
	:adapter => 'sqlserver',
	:mode => 'dblib',
	:dsn => 'your-dsn-name',
	:host => 'host-created-from-FreeTDS',
	:databae => 'database-name',
	:username => 'db-user-name',
	:password => 'db-user-password'
)

# 	Table: Users
# 		=> ID (pk)
# 		=> first_name
# 		=> last_name
#
class User < ActiveRecord::Base
	self.table_name = "Demo.dbo.Users"
	self.primary_key = "ID"
end


# Test some activerecord methods
puts "Total count: #{User.all.count}"
puts "Find record by primary key:  #{User.find(1)}"
