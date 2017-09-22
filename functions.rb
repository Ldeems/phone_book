
require 'pg'
enable :sessions
load './mycreds.rb' if File.exist?('./mycreds.rb')

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
        answer = "you joined this phone book"
        db.exec("insert into phonebook(firstname,lastname,address,city,state,zipcode,phonenumber)VALUES('#{arr[0]}','#{arr[1]}','#{arr[2]}','#{arr[3]}','#{arr[4]}','#{arr[5]}','#{arr[6]}')")
    end
    answer

end

def getputoftable()

	db_params = {
		host: ENV['host'],
		port: ENV['port'],
		dbname: ENV['dbname'],
		user: ENV['user'],
		password: ENV['password']
	}

	db = PG::Connection.new(db_params)

	data = [] 

	db.exec( "SELECT * FROM phonebook" ) do |result|
	      result.each do |row|
	          data << row.values
	        end
	        p "#{data} data is here"
	    end
	data    
end

def searchbypphonenum(num)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)
answer = ""
check = db.exec("SELECT * FROM phonebook WHERE phonenumber = '#{num}'")

    if check.num_tuples.zero? == false
        answer = check.values
    else
        answer = "seems we do not have that number"
        
    end
    answer
end	



def updatefunction(old,arr)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)

 
   
    db.exec("UPDATE phonebook SET firstname = '#{arr[0]}',lastname = '#{arr[1]}',address = '#{arr[2]}',city = '#{arr[3]}',state = '#{arr[4]}',zipcode = '#{arr[5]}',phonenumber = '#{arr[6]}'WHERE phonenumber = '#{old}'")
        
p "Your information has been updated"      
end




def deletefunction(del)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)


        db.exec("DELETE FROM phonebook WHERE phonenumber = '#{del}'")
    
p "The information has been deleted"
end	




def checklogin(user,pass)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)

	checkuser = db.exec("SELECT * FROM pblogin WHERE username = '#{user}'")

	if checkuser.num_tuples.zero? == false
        checkpass = db.exec("SELECT * FROM pblogin WHERE answer = '#{pass}'")
        if checkpass.num_tuples.zero? == false
        	message = "successful login"
        else
			message = "failed login"
		end	
    else
       message = "failed login"
    end
    message
end  


def putinloginpb(user,pass)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)	


answer = ""
check = db.exec("SELECT * FROM pblogin WHERE username = '#{user}'")

    if check.num_tuples.zero? == false
        answer = "Your Number is already being used"
    else
        answer = "you joined this phone book"
        db.exec("insert into pblogin(username,answer)VALUES('#{user}','#{pass}')")
    end
    answer

end


    