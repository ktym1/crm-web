require "sinatra"

get '/' do 
	@crm_app_name = "My CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

get '/contacts' do
	erb :contacts
end
