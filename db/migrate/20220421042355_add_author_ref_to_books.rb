# We used rails g migration AddAuthorRefToBooks to add an author reference to books.
# We can see below 'null: false', meaning this value cannot be null - a book MUST have an author.
# We generated BOTH MIGRATIONS before running 'rails db:migrate' to do both at once and prevent issues of some kind that
# I missed. The 'rails db:migrate' command FAILED, as we hadn't assigned author refernces/IDs. The reference cannot be
# null (as we just covered), yet there is currently no value. Hence an error.
class AddAuthorRefToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :author, null: false, foreign_key: true
  end
end
