require "sinatra"

get '/' do 
	@crm_app_name = "My CRM"
	erb :index		#"Main Menu" - we're replacing 'Main menu' with index.erb
end

