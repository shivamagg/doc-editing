class Document < ApplicationRecord
	has_many :edits
	has_many :users, through: :edits
	
	def is_available?
		return self.is_available
	end

	def is_available!
		self.is_available = true
		self.save
	end

	def is_not_available!
		self.is_available = false
		self.save
	end
end
