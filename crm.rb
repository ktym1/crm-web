require_relative "contact"
require_relative "rolodex"
require "sinatra"

get '/' do 
	@crm_app_name = "My CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

get '/contacts' do #view all contact
	@contacts = [] #creating an empty array to store my instances of Contact class
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