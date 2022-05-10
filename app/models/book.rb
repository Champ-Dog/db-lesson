class Book < ApplicationRecord
    # resourcify
    belongs_to :author
    has_many :book_genres
    has_many :genres, through: :book_genres

    has_one_attached :cover

    # This will raise an error if user attempts to create a book without a title
    validates :title, presence: true
end
