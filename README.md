# ruby-ms-sql-boilerplate
**Tested with Ruby 1.9.3 / MS SQL Server 2012**

***For compatibility of MS SQL Server 2016, checkout ```ms-sql-2016``` branch.***

This is a super duper bare bones ruby script that establishes a connection to Microsoft SQL Server 2012 and earlier versions. It uses Rails' Activerecord gem to map the database tables into Ruby classes.

All necessary gems can be found in the ```Gemfile``` and should be installed through ```bundler```.  Just a quick look at the required gems and their versions.

```ruby
gem 'ruby-odbc', '0.99994'
gem 'tiny_tds', '0.4.5'
gem 'activerecord', '3.2.13'
# MSSQL SERVER 2005, 2008, 2010, 2011, 2012 are supported
gem 'activerecord-sqlserver-adapter', '3.2.10'

```

## Prerequiste
The 'tiny_tds' gem requires some extra steps before it can be installed successfully.

**1) MacOS (tested on Sierra)**
Install packages
```shell
brew install unixodbc
brew install freetds --with-unixodbc
```
**2) FREETDS**

Located through homebrew installation. Version number in path may differ.

```conf
# File: /usr/local/Cellar/freetds/1.00.54/etc/freetds.conf
[global]
tds version = 8.0

[CUSTOM-SERVERNAME]				# <- a stored `servername`, name it whatever
host = 192.168.1.23  			# <- your database server
port = 1433
tds version = 8.0
```

Test FreeTDS Connection
```shell
tsql -S CUSTOM-SERVERNAME -U your-db-user -P your-db-password
```


**3) UNIXODBC**

Located through homebrew installation. Version number in path may differ. This file specifies the driver (If file doesn't exist, create it):

```ini
# File: /usr/local/Cellar/unixodbc/2.3.4/etc/odbcinst.ini
[FreeTDS]
Description = FreeTDS Driver
Driver = /usr/local/Cellar/freetds/1.00.54/lib/libtdsodbc.so # /usr/local/lib/libtdsodbc.so also works
Setup = /usr/local/Cellar/freetds/1.00.54/lib/libtdsodbc.so
UsageCount = 1
```

This file will contain the DSN (If file doesn't exist, create it):
```ini
# File: /usr/local/Cellar/unixodbc/2.3.4/etc/odbc.ini
[FIRST-DSN] 							# <- name you DSN to something meaningful
Description         = DSN to connect to MS SQLServer
Driver              = FREETDS 						# <- created from odbcinst.ini
Trace               = Yes
TraceFile           = /tmp/sql.log
Database            = Demo					# <- your database
Servername          = CUSTOM-SERVERNAME 			# <- servername created from freetds.conf
UserName            = artimys 					# <- your db user
Password            = password 					# <- your db password
Port                = 1433
Protocol            = 8.0
ReadOnly            = No
RowVersioning       = No
ShowSystemTables    = No
ShowOidColumn       = No
FakeOidIndex        = No
```

Test DSN Connection
```shell
isql FIRST-DSN your-db-user your-db-password -v
```




## Installation
1. Clone this repo:
```ruby
git clone git@github.com:artimys/ruby-ms-sql-boilerplate.git
```

2. Install gems:
```shell
$ bundle
```

3. Modify ```lib/example.rb``` with your settings:
```ruby
ActiveRecord::Base.establish_connection(
	:adapter => 'sqlserver',
	:mode => 'odbc',
	:dsn => 'FIRST-DSN', 				# <- your custom DSN name if different from above
	:username => 'db-user-name',
	:password => 'db-user-password'
)
```
Also modify the small User class snippet to match a class in your database:
```ruby
class User < ActiveRecord::Base
	self.table_name = "Users"
	self.primary_key = "ID"
end

# Test some activerecord methods
puts "Total count: #{User.all.count}"
puts "Find record by primary key:  #{User.find(1)}"
```

4. Execute ruby script
```ruby
ruby lib/example.rb
```
