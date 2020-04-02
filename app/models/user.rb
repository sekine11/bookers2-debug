class User < ApplicationRecord
  attachment :profile_image
  validates :introduction, length: { maximum: 50 }
  validates :name, length: { in: 2..20 }
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
end
