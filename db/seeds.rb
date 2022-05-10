# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Test data for authentication/authorisation lesson

User.destroy_all
Author.destroy_all

user = User.create(email: 'admin@test.com', password: 'admin123')
user.add_role :admin

editor = User.create(email: 'foo@test.com', password: 'fubar1337')
editor.add_role :editor

# Deleting Author first creates 'orphan' objects. There will be Books left (before they are deleted) that have a
# reference to Author objects that no longer exist. Trying to run 'rails db:seed' like this will result in an error, as
# by default Rails will not allow such behaviour
Author.destroy_all
# We changed author.rb in models to destroy all books by an author when that author is deleted
# Book.destroy_all

jk = Author.create(first_name: "JK", last_name: "Rowling")
clarke = Author.create(first_name: "Arthur", last_name: "Clarke")
asimov = Author.create(first_name: "Isaac", last_name: "Asimov")

jk.books.create(title: "Harry Potter and the Goblet of Fire")
jk.books.create(title: "Harry Potter and the Half-Blood Prince")
clarke.books.create(title: "2001: A Space Odyssey")
clarke.books.create(title: "A Fall Of Moondust")
asimov.books.create(title: "Foundation")
asimov.books.create(title: "I, Robot")

# Author.create(first_name: "JK", last_name: "Rowling")
# Author.create(first_name: "Arthur", last_name: "Clarke")
# Author.create(first_name: "Isaac", last_name: "Asimov")

# Book.create(title: 'Harry Potter and the Goblet of Fire', author: 'JK Rowling')
# Book.create(title: '2001: A Space Odyssey', author: 'Arthur C. Clarke')
# Book.create(title: 'Foundation', author: 'Isaac Asimov')

puts "Users: #{User.count}"
puts "Roles: #{Role.count}"
puts "Authors: #{Author.count}"
puts "Books: #{Book.count}"