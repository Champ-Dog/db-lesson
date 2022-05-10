# We started with authors as a field for Books, but we decided later we wanted authors to be a seperate entity.
# Books now only need to store the author id to be connected to the author. We used 'rails g migration
# RemoveAuthorFromBooks author' to generate this method.
class RemoveAuthorFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author, :string
  end
end
