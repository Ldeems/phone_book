require 'sinatra'
require 'pg'
require_relative 'functions.rb'
enable :sessions
load './local_env.rb' if File.exist?('./local_env.rb')

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)


def putintable(arr)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)	


answer = ""
check = db.exec("SELECT * FROM phonebook WHERE phonenumber = '#{arr[-1]}'")

    if check.num_tuples.zero? == false
        answer = "Your Number is already being used"
    else
        answer = "you join this phone book"
        db.exec("insert into phonebook(firstname,lastname,address,city,state,zipcode,phonenumber)VALUES('#{arr[0]}','#{arr[1]}','#{arr[2]}','#{arr[3]}','#{arr[4]}','#{arr[5]}','#{arr[6]}')")
    end
    answer

end

def getputoftable

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)	