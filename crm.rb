require_relative "contact"
require_relative "rolodex"
require "sinatra"

@@rolodex= Rolodex.new #create a class variable before the 'routes' (route = get "/") so Sinatra can access it from anywhere in route blocks and views

get '/' do 
	@crm_app_name = "My CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

# ***no longer need @contacts array, because @@rolodex class instance can access contacts array 
get '/contacts' do #view all contact
#    #@contacts = [] #create an empty array to store Contact class instances; 
 	# @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
 	# @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
 	# @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

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

post '/contacts' do #using params to submit a request/form; contains body of the request; params hash is avialable in any route block
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:role]) #initializing a class of Contact to pass through the Rolodex method
	@@rolodex.add_a_contact(new_contact)
	redirect to('/contacts')
end

