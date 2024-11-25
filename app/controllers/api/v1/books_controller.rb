class Api::V1::BooksController < ApiController

  load_and_authorize_resource

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

end
