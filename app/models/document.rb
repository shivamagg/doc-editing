class Document < ApplicationRecord
	has_many :edits
	has_many :users, through: :edits
	
	def is_available?
		return self.is_available
	end
end
