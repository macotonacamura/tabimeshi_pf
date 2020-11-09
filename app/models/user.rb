class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates_uniqueness_of :user_name
  validates :introduction, length: { maximum: 50 }

  has_many :sns_credentials, dependent: :destroy

  mount_uploader :profile_image, ProfileImageUploader

  has_many :reviews, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_list, through: :likes, source: 'review'
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



  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          user_name: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        user_name: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end



  def self.partical(content)
    if content
      where("user_name LIKE ?", "%#{content}%")
    else
      where(is_deleted: false)
    end
  end

end
