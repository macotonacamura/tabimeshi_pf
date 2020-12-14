class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  validates :user_name, uniqueness: true,  presence: true
  validates :introduction, length: { maximum: 50 }

  has_many :sns_credentials, dependent: :destroy

  mount_uploader :profile_image, ProfileImageUploader

  has_many :reviews, foreign_key: :user_id, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_list, through: :likes, source: 'review'
  has_many :relationships
  #has_many :relationships, foreign_key: :user_id
  #has_many :relationships, foreign_key: :follow_id
  has_many :followings, through: :relationships, source: :follow #中間テーブル：relationships
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

#フォロー機能
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

#FBログイン
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

#ユーザー検索
  def self.partical(content)
    if content
      where("user_name LIKE ?", "%#{content}%")
    else
      where(is_deleted: false)
    end
  end

#ユーザーランキング機能(フォロワーが多い順で5名の情報を取得)
   def self.create_all_ranks
      user = User.joins(:followers).group(:follow_id).order('count(follow_id) desc').limit(5)
     return user
   end


end
