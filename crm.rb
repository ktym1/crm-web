require "sinatra"
require "data_mapper"
#require_relative "contact" - remove contact class & delete the class bc of DataMapper

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource #since we've included this resource module, DataMapper will start to consider this class to represent a single database table. Every time we createa a new Contact record, it will automatically be inserted into the contacts database table.

	property :id, Serial #serial is an integer that automatically increments
	property :first_name, String
	property :last_name, String
	property :email, String
	property :role, String

end

DataMapper.finalize #add at end of class definitions
DataMapper.auto_upgrade! #effects any changes to the underlying structure of the tables or columns

get '/' do 
	@crm_app_name = "Kerry's CRM" #setting up an instance variable that we can pass along
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

get '/contacts/new' do
	erb :contact_new
end

post '/contacts' do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:role => params[:note]
		)

		redirect to("/contacts/#{contact.id}") #need to update from new_contact to contact bc I changed the variable name
	end


	get '/contacts' do
		@contacts = Contact.all  	
		erb :contact_list
	end


get '/contacts/:id/edit' do #modify an existing contact
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :contact_edit #if contact IDs match, go to the edit page
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		# @contact.first_name = params[:first_name]
		# @contact.last_name = params[:last_name]
		# @contact.email = params[:email]
		# @contact.role = params[:role]
		@contact.update(
			:first_name => params[:first_name],
			:last_name => params[:last_name],
			:email => params[:email], 
			:role =>[:role]
			)
		# @contact.id = params[:id] Need to delete this ID because we're taking it in as an integer and passing it back as a string on our redirect, causing error.
		# @contact.id => 1001
		# @contact.id => "1001"

		redirect to ("/contacts/#{@contact.id}") #string interpolation should be with double quotes
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i) #DataMapper uses Contact.get to return the contact object. 
	if @contact
		# Patterns work by putting a semicolon ahead of the item we want to match and capture. Every time we use a pattern or submit any information, it will always be available inside the params hash.
		erb :show_contact 
	else
		raise Sinatra::NotFound
	end
end

delete '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		# @@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end
