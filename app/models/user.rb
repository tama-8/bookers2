class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  # フォロー
  has_many :active_relationships,class_name:"Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
   # フォロワー
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length:{ minimum: 2 ,maximum: 20 }, uniqueness: true
  validates :introduction, length:{ maximum: 50 }
  # ユーザーごとのプロフィール画像を保存
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename:  "no_image.jpg" , content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def already_favorited?(book)
    puts book.inspect
    self.favorites.exists?(book_id: book.id)
  end

# フォローしているか確認するとき
  def following?(user)
    followings.include?(user)
  end

# フォローするとき
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # フォローを外すとき
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

end
