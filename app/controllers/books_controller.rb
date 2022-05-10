class BooksController < ApplicationController
  # DEBUG - REMOVE FOR PRODUCTION
  # skip_before_action :verify_authenticity_token

  # This is placed before all other instructions to properly secure the Controller; to make sure NOTHING happens before
  # verifying authentication. We then changed this to allow users to see books before logging in, without allowing them
  # to edit anything.
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_auth
  # We don't want to do this before EVERY action, only for show, update, destroy - others don't provide params
  # to select an individual book. We use the 'only' modifier to do this. OR 'except: [:index, :create, :new]'
  before_action :set_book, only: [:show, :update, :destroy, :edit]
  before_action :set_authors, only: [:new, :edit, :create, :update]
  # We initially set 'index' to render so that we could focus on setting up the Controller in isolation to the View
  def index
    @books = Book.all
  end

  def show
  # @book = Book.find(params[:id])
  rescue StandardError
      render plain: 'Book not found!'
  end

  # We included a list of authors to choose from
  def new
    @book = Book.new
  end

  # Rails will automatically reject/filter out requests that would change the database, to protect against
  # SQL injections
  # We needed to change from 'book' to '@book' to fix scope issues and allow the error checking here to work.
  # Without this, the 'book' didn't have access to necessary attributes like cover, author, etc; and would
  # disappear between Begin and Rescue due to scope issues
  # The 'render' instruction is to allow the information entered already to not be lost, if we used 'redirect'
  # it would count as a new HTTP request, and the information would be lost
  def create
    begin
      @book = Book.new(book_params)
      @book.save!
      redirect_to @book
    rescue
      flash.now[:alert] = @book.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def edit
  end

  def update
    begin
      @book.update!(book_params) 
      redirect_to @book
    rescue
      flash.now[:alert] = @book.errors.full_messages.join('<br>')
      render 'edit'
    end
  end

  def destroy
    # The first line will ensure the upload image on Cloudinary is destroyed when a book is destroyed
    @book.cover.purge
    @book.destroy
    redirect_to books_path
  end

  private

  # Checks users are authorised before actions
  # 'authorize' is a method from pundit
  def check_auth
    authorize Book
  end

  # This is to DRY our code. We call this with 'before_action' above to set the variable
  def set_book
    @book = Book.find(params[:id])
  end

  def set_authors
    @authors = Author.order(:last_name)
  end

  # This tells Rails to permit the included params, it will 'sanitize' these and include them, and filter out
  # anything else
  def book_params
    return params.require(:book).permit(:title, :author_id, :cover)
  end
end
