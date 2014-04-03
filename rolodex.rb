class Rolodex
	attr_reader :contacts

	def initialize
	@contacts = []
	@id = 1000
	end


	def add_a_contact(foo)
		# foo is actually going to be a Contact object (instance of Contact)
		foo.id = @id #passing in the argument from crm.rb, so need to refer as new_contact in method
		@contacts << foo
		@id += 1
	end

	def delete_a_contact(foo)
		# in this case, foo is actually a string representing an ID
		result = nil
		@contacts.each do |contact| 
			if contact.id == foo.to_i
				result = contact
			end
		end 
		@contacts.delete(result) if result != nil
	end

	def find(foo)
		@contacts.find {|contact| contact.id == foo}
	end

end