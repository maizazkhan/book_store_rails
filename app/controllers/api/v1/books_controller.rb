class Api::V1::BooksController < ApiController
  load_and_authorize_resource

  resource_description do
    short 'Books Management'
    description 'API for managing books in the bookstore.'
  end

  api :GET, '/api/v1/books', 'Fetches all books'
  param :q, String, desc: 'Query parameter for search i-e q=title_cont:Sherlock'
  def index
    @q = Book.ransack(
      title_or_author_or_description_cont: params[:q]
    )
    @books = @q.result(distinct: true)
  end

  api :GET, '/api/v1/books/:id', 'Shows a single book'
  param :id, :number, required: true, desc: 'ID of the book'
  def show
    @book = Book.find(params[:id])
  end

  api :POST, '/api/v1/bookstores/:bookstore_id/books', 'Creates a new book'
  param :bookstore_id, :number, required: true, desc: 'ID of the bookstore'
  param :book, Hash, desc: 'Book info', required: true do
    param :title, String, desc: 'Title of the book', required: true
    param :author, String, desc: 'Author of the book', required: true
    param :publisher, String, desc: 'Publisher of the book', required: false
    param :genre, String, desc: 'Genre of the book', required: false
    param :year, :number, desc: 'Year of publication', required: false
    param :page_count, :number, desc: 'Number of pages', required: false
    param :user_id, :number, desc: 'ID of the user', required: false
    param :description, String, desc: 'Description of the book', required: false
    param :price, :number, desc: 'Price of the book', required: false
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
  api :PUT, '/api/v1/bookstores/:bookstore_id/books/:id', 'Updates an existing book'
  param :bookstore_id, :number, required: true, desc: 'ID of the bookstore'
  param :id, :number, required: true, desc: 'ID of the book'
  param :book, Hash, desc: 'Book info', required: true do
    param :title, String, desc: 'Title of the book', required: false
    param :author, String, desc: 'Author of the book', required: false
    param :publisher, String, desc: 'Publisher of the book', required: false
    param :genre, String, desc: 'Genre of the book', required: false
    param :year, :number, desc: 'Year of publication', required: false
    param :page_count, :number, desc: 'Number of pages', required: false
    param :user_id, :number, desc: 'ID of the user', required: false
    param :description, String, desc: 'Description of the book', required: false
    param :price, :number, desc: 'Price of the book', required: false
  end
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
  api :DELETE, '/api/v1/bookstores/:bookstore_id/books/:id', 'Deletes an existing book'
  param :bookstore_id, :number, required: true, desc: 'ID of the bookstore'
  param :id, :number, required: true, desc: 'ID of the book'
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
