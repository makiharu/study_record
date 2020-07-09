class Contact < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true
	validates :content, presence: true, length: { maximum: 1000 }
end
