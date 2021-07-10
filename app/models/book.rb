class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word, search)
    if search == "perfect_match"
      Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "backword_match"
      Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end
end
