class BookComment < ApplicationRecord
	validates :content, presence: true
	belongs_to :user
	belongs_to :book
end
