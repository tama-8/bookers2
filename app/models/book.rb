class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: 'user'
  has_many :book_comments, dependent: :destroy
  #Bookモデルは Favoriteモデルを通じて Userモデルへの間接的な繋がりを持つ
  has_many :favorited_users, through: :favorites, source: :user

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum: 200 }

  #検索機能
  def self.looks(search,word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
