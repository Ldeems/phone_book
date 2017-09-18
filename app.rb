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

get '/' do
	erb :getinfo
end

post '/outinfo' do
	info = []
  	info << params[:firstname]
  	info << params[:lastname]
  	info << params[:address]
  	info << params[:city]
  	info << params[:state]
  	info << params[:zipcode]
  	info << params[:phonenumber]
  	putintable(info)
  	#datafromtable = getputoftable()
  	#p "#{datafromtable} loooooook here"
  	redirect "/review"
end

get '/review' do 
	datafromtable = getputoftable()

	erb :review, locals:{datafromtable:datafromtable} 
end

post '/search' do
  	sphonenumber = params[:sphonenumber]
  	p "#{sphonenumber} first print!!!!!!!!"
  	redirect "/sres?sphonenumber=" + sphonenumber
end	

get '/sres' do
 	sphonenumber = params[:sphonenumber]
 	found = searchbypphonenum(sphonenumber)

 	#p "#{found}"
 	erb :sres, locals:{found:found}
end	