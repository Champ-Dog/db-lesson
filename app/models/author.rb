class Author < ApplicationRecord
    # We changed this to allow our 'seeds' to run as intended, and to make sure when an Author is destroyed, all of their books are as well. This prevents orphan objects (books pointing to an author that doesn't exist)
    has_many :books, dependent: :destroy

    def full_name
      return "#{first_name} #{last_name}"
    end
end

