class BookComment < ApplicationRecord
    belongs_to :book
    belongs_to :user

    validates :content, length:{ maximum: 50 }
end
