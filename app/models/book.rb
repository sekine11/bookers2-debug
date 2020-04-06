class Book < ApplicationRecord
	validates :title, presence: true
	validates :body, presence: true
	validates :body, length: { maximum: 200 }
	belongs_to :user, optional: true
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search,search_method)
	    if search_method == '前方一致'
	        self.where(['title LIKE ?', "#{search}%"])
	      elsif search_method == '後方一致'
	        self.where(['title LIKE ?', "%#{search}"])
	      elsif search_method == '完全一致'
	        self.where(['title LIKE ?', "#{search}"])
	      else search_method == '部分一致'
	        self.where(['title LIKE ?', "%#{search}%"])
	    end
  	end
end
