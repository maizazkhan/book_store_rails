# app/controllers/purchases_controller.rb
class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookstore
  before_action :set_book, only: [:create]
  load_and_authorize_resource :bookstore  # Ensure we're working within the correct bookstore
  load_and_authorize_resource :book, through: :bookstore  # Authorize book actions through bookstore

  # POST /bookstores/:bookstore_id/books/:id/purchase
  def create
    # Add 5% to the price
    price_with_tax = @book.price * 1.05


    # Create a new purchase record
    @purchase = Purchase.new(
      user: current_user,         # Current logged-in user
      book: @book,                # The book being purchased
      bookstore: @bookstore,      # The bookstore where the purchase is made
      price: price_with_tax       # The final price with the 5% tax
    )

    if @purchase.save
      redirect_to bookstore_books_path(@bookstore), notice: 'Purchase was successful!'
    else
      redirect_to bookstore_books_path(@bookstore), alert: 'There was an issue with your purchase.'
    end
  end

  private

  def set_bookstore
    @bookstore = Bookstore.find(params[:bookstore_id])
  end

  def set_book
    @book = @bookstore.books.find(params[:id])
  end
end
