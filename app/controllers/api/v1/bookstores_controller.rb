class Api::V1::BookstoresController < ApiController
  load_and_authorize_resource

  def index
    @q = Bookstore.ransack(params[:q])
    @book_stores = @q.result(distinct: true)
  end

  # GET /api/v1/bookstores/:id
  def show
    @book_store = Bookstore.find(params[:id])
  end

  # POST /api/v1/bookstores
  def create
    @bookstore = Bookstore.new(bookstore_params)
    if @bookstore.save
      render json: @bookstore, status: :created
    else
      render json: @bookstore.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/bookstores/:id
  def update
    @bookstore = Bookstore.find(params[:id])
    if @bookstore.update(bookstore_params)
      render json: @bookstore
    else
      render json: @bookstore.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/bookstores/:id
  def destroy
    @bookstore = Bookstore.find(params[:id])
    @bookstore.destroy
    head :no_content
  end

  private

  def bookstore_params
    params.permit(:name, :address, :phone)
  end

end
