require_relative "contact"
require_relative "rolodex"
require "sinatra"

@@rolodex= Rolodex.new #create a class variable before the 'routes' (route = get "/") so Sinatra can access it from anywhere in route blocks and views

get '/' do 
	@crm_app_name = "My CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

get '/contacts' do #view all contact
	#@contacts = [] # no longer need because the @@rolodex class instance gives ua access to contacts array #create an empty array to store Contact class instances; 
	@contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
	@contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
	@contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

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