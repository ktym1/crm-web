class Contact

	attr_accessor :first_name
	attr_accessor :last_name
	attr_accessor :email
	attr_accessor :note
	attr_accessor :id


	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
	end

	def to_s
		"Name: #{@name}\nNotes: #{note}"
	end	
end
# contact_one = Contact.new("","","test","")
# contact_one.
