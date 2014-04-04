require "sinatra"
require "data_mapper" #data_mapper needs an underscore
#require_relative "contact" removing this file bc we have datamapper
require_relative "rolodex"

DataMapper.setup(:default, "sqlite3:database.sqlite3") #this is where we are telling datamapper to start up and where we want to point our data

@@rolodex= Rolodex.new #create a class variable before the 'routes' (route = get "/") so Sinatra can access it from anywhere in route blocks and views

@@rolodex.add_a_contact(Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")) #creating a fake contact when loading the app.œ

class Contact
	include DataMapper::Resource

	property :id, Serial #this replaces the initialize from below
	property :first_name, String #this is us defining the columns of the database table
	property :last_name, String
	property :email, String
	property :role, String

	# attr_accessor :id, :first_name, :last_name, :email, :role

	# def initialize(first_name, last_name, email, role)
	# 	@first_name = first_name
	# 	@last_name = last_name
	# 	@email = email
	# 	@role = role
	# end
end

DataMapper.finalize #"I'm done defining tables, so don't worry about it anymore" + validates if there are errors. It's outside a class.
DataMapper.auto_upgrade! #if you change any properties, it will update the structure of properties.




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
	@contacts = Contact.all #getting data from database, returns an arary of objects
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
		@contact.id = params[:id]

		redirect to ('/contacts/#{@contact.id')
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i) #generalized this route so that :id can be any contact id, making it a wildcard.
	erb :show_contact # Patterns work by putting a semicolon ahead of the item we want to match and capture. Every time we use a pattern or submit any information, it will always be available inside the params hash.
end

contact = @@rolodex.find(1000)


