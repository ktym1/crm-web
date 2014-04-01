class Rolodex
	attr_reader :contacts

	def initialize
	@contacts = []
	@id = 1000


	def add_a_contact(contact)
		contact.id = @id
		@contacts << contact
		@id += 1
	end
end
