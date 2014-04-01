class Contact

	attr_accessor :first_name
	attr_accessor :last_name
	attr_accessor :email
	attr_accessor :role
	attr_accessor :id


	def initialize(first_name, last_name, email, role)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@role = role
	end

	def to_s
		"First Name: #{@first_name}\nLast Name: #{@last_name}\nEmail: #{@email}\NRole: #{@role}"
	end	
end
# contact_one = Contact.new("","","test","")
# contact_one.
