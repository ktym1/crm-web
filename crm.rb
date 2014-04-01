require_relative "contact"
require "sinatra"

get '/' do 
	@crm_app_name = "My CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

get '/contacts' do #view all conatct
	erb :contact_list
end

get '/contacts/new' do
	erb :contact_new
end

get '/contacts/:id' do #view a contact
	erb :contact_id
end

get '/contacts/:id/edit' do #modify an existing contact
	erb :contact_edit
end