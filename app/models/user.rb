class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_image, ProfileImageUploader

  has_many :reviews, dependent: :destroy



  #退会ユーザーをログインできないようにする active_for_authentication?
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
