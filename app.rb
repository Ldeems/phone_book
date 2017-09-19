require 'sinatra'
require 'pg'
require_relative 'functions.rb'
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
 	session[:sphonenumber] = params[:sphonenumber]
 	session[:found] = searchbypphonenum(session[:sphonenumber])

 	#p "#{found}"
 	erb :sres, locals:{found:session[:found]}
end	

post '/goback' do
  redirect '/'
end

post '/update' do
	update = params[:new]
	#old = session[:sphonenumber]
	ran = updatefunction(session[:sphonenumber],update)
	
	#p "#{ran}, and here is updated #{datafromtable}"
	redirect '/finalreview?ran=' + ran
end


post '/delete' do
	dele = deletefunction(session[:sphonenumber])	
	#p "#{dele}"
	redirect '/finalreview?dele=' + dele
end


get '/finalreview' do
	ran = params[:ran]
	dele = params[:dele]
	datafromtable = getputoftable()

	erb :finalreview, locals:{ran:ran, dele:dele, datafromtable:datafromtable}
end	