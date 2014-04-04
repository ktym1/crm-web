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


 get '/contacts' do  	
 	erb :contact_list
 end


get '/contacts/:id/edit' do #modify an existing contact
	puts params

	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :contact_edit #if contact IDs match, go to the edit page
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		
		# @contact.id = params[:id] Need to delete this ID because we're taking it in as an integer and passing it back as a string on our redirect, causing error.
		# @contact.id => 1001
		# @contact.id => "1001"

		redirect to ("/contacts/#{@contact.id}") #string interpolation should be with double quotes
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id" do
	#generalized this route so that :id can be any contact id, making it a wildcard.
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		# Patterns work by putting a semicolon ahead of the item we want to match and capture. Every time we use a pattern or submit any information, it will always be available inside the params hash.
		erb :show_contact 
	else
		raise Sinatra::NotFound
	end
end

delete '/contacts/:id' do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end
