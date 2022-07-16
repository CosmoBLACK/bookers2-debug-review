class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # 自分がフォローする（与フォロー）側の関係性
  has_many :followings, throuth: :relationships, source: :followerd # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # 自分がフォローされる（被フォロー）側の関係性
  has_many :followers, throuth: :reverse_of_relationships, source: :follower # 被フォロー関係を通じて参照→自分をフォローしている人

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user_id) # フォローしたときの処理
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id) # フォローを外すときの処理
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user) # フォローしているか判定
    followings.include?(user)
  end
end
