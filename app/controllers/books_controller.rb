class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookstore
  before_action :set_book, only: [:show, :edit, :update, :destroy, :purchase]
  load_and_authorize_resource :bookstore  # Ensure we're working within the right bookstore
  load_and_authorize_resource :book, through: :bookstore  # Authorize book actions through bookstore

  # GET /bookstores/:bookstore_id/books
  def index
    # Initialize the search object
    @q = @bookstore.books.ransack(params[:q])
    # Execute the search and assign to @books
    @books = @q.result(distinct: true)
  end

  # GET /bookstores/:bookstore_id/books/:id
  def show
  end

  # GET /bookstores/:bookstore_id/books/new
  def new
    @book = @bookstore.books.build
  end

  # POST /bookstores/:bookstore_id/books
  def create
    @book = @bookstore.books.build(book_params)
    if @book.save
      redirect_to bookstore_books_path(@bookstore), notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # GET /bookstores/:bookstore_id/books/:id/edit
  def edit
  end

  # PATCH/PUT /bookstores/:bookstore_id/books/:id
  def update
    if @book.update(book_params)
      redirect_to bookstore_book_path(@bookstore, @book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookstores/:bookstore_id/books/:id
  def destroy
    @book.destroy
    redirect_to bookstore_books_path(@bookstore), notice: 'Book was successfully destroyed.'
  end

  private

  def set_bookstore
    @bookstore = Bookstore.find(params[:bookstore_id])
  end

  def set_book
    @book = @bookstore.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :genre)
  end
end
