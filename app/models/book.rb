class Book < ApplicationRecord
  # resourcify
  belongs_to :author
  has_many :book_genres
  has_many :genres, through: :book_genres

  has_one_attached :cover

  # This will raise an error if user attempts to create a book without a title
  # We do validation at the model to prevent circumventing the controls. If we use Controller, someone can use Rails
  # console to generate a Model directly. If we use Views, Postman or similar can allow someone to bypass the form.
  # Due to MVC layout, all routes end with a representaiton of a Model, so doing it here is like doing it at the root
  validates :title, presence: true

  # We can include custom error messages like so (note the message will be prefixed with the name of the field, such
  # that the below will present as 'Title: Please provide a title'):
  # validates :title, presence: { message: 'Please provide a title' }

  # We can also set other validations, such as minimum characters, as below. Note that we did not implement this in
  # this case as some books may have only one character as a title
  # validates :title, presence: true, length: { minimum: 3 }
end
