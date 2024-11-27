class Api::V1::BooksController < ApiController

  load_and_authorize_resource

  def index
    @q = Book.ransack(
      title_or_author_or_description_cont: params[:q]
    )
    @books = @q.result(distinct: true)
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @bookstore = Bookstore.find(params[:bookstore_id])
    @book = @bookstore.books.new(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/bookstores/:bookstore_id/books/:id
  def update
    @bookstore = Bookstore.find(params[:bookstore_id])
    @book = @bookstore.books.find(params[:id])
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/bookstores/:bookstore_id/books/:id
  def destroy
    @bookstore = Bookstore.find(params[:bookstore_id])
    @book = @bookstore.books.find(params[:id])
    @book.destroy
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :genre, :year, :page_count, :user_id, :description, :price)
  end

end
