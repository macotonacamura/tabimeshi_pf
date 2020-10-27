class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_image, ProfileImageUploader

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :review_comments, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow #中間テーブル：relationships
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id) #既にフォロー済みの場合重複してフォローされる事を防ぐ
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id) #フォロー済みならアンフォローできる
    relationship.destroy if relationship
  end

  def following?(other_user) #self.followingsによりフォローしているUserを取得、includeでother_userが含まれているかどうか
    self.followings.include?(other_user)
  end



  #退会ユーザーをログインできないようにする active_for_authentication?
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
