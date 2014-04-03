require "sinatra"

require_relative "contact"
require_relative "rolodex"


@@rolodex= Rolodex.new #create a class variable before the 'routes' (route = get "/") so Sinatra can access it from anywhere in route blocks and views

@@rolodex.add_a_contact(Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")) #creating a fake contact when loading the app.œ

get '/' do 
	@crm_app_name = "Kerry's CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

# ***no longer need @contacts array, because @@rolodex class instance can access contacts array 
#get '/contacts' do #view all contact
#    #@contacts = [] #create an empty array to store Contact class instances; 
 	# @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
 	# @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
 	# @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

get '/contacts/new' do
	erb :contact_new
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:role]) #initializing a class of Contact to pass through the Rolodex method
	@@rolodex.add_a_contact(new_contact) #this arguement doesn't need to be foo. it's only the object that's being created and passed to rolodex
 	redirect to("/contacts/#{new_contact.id}") #we are substituting the instance of new_contact that we created, and the id since we need an actual number.
end

get '/contacts/:id/delete' do
	@@rolodex.delete_a_contact(params[:id])
	redirect to('/contacts')
end


get '/contacts' do  	
 	erb :contact_list
end


get '/contacts/:id/edit' do #modify an existing contact
	@contact = @@rolodex.find(params[:id].to_i) #need to find corresponding contact object and put in a variable so our view can access it
	if @contact
		erb :contact_edit #if contact IDs match, go to the edit page
	else
		raise Sinatra::Not Found # :: operator that allows constants, instance methods and class methods defined within a clas or module to be accessed from anywhere outside the class or module
	end
end
end

get "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i) #generalized this route so that :id can be any contact id, making it a wildcard.
	erb :show_contact # Patterns work by putting a semicolon ahead of the item we want to match and capture. Every time we use a pattern or submit any information, it will always be available inside the params hash.
end

contact = @@rolodex.find(1000)


