class Api::V1::BookstoresController < ApiController
  load_and_authorize_resource

  resource_description do
    short 'Bookstores Management'
    description 'API for managing bookstores in the system.'
  end

  api :GET, '/api/v1/bookstores', 'Fetches all bookstores'
  param :q, String, desc: 'Query parameter for search i-e q=title_cont:Sherlock'
  def index
    @q = Bookstore.ransack(params[:q])
    @book_stores = @q.result(distinct: true)
  end

  # GET /api/v1/bookstores/:id
  api :GET, '/api/v1/bookstores/:id', 'Shows a single bookstore'
  param :id, :number, required: true, desc: 'ID of the bookstore'
  def show
    @book_store = Bookstore.find(params[:id])
  end

  # POST /api/v1/bookstores
  api :POST, '/api/v1/bookstores', 'Creates a new bookstore'
  param :bookstore, Hash, desc: 'Bookstore info', required: true do
    param :name, String, desc: 'Name of the bookstore', required: true
    param :address, String, desc: 'Address of the bookstore', required: true
    param :phone, String, desc: 'Phone number of the bookstore', required: true
  end
  def create
    @bookstore = Bookstore.new(bookstore_params)
    if @bookstore.save
      render json: @bookstore, status: :created
    else
      render json: @bookstore.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/bookstores/:id
  api :PUT, '/api/v1/bookstores/:id', 'Updates an existing bookstore'
  param :id, :number, required: true, desc: 'ID of the bookstore'
  param :bookstore, Hash, desc: 'Bookstore info', required: true do
    param :name, String, desc: 'Name of the bookstore', required: false
    param :address, String, desc: 'Address of the bookstore', required: false
    param :phone, String, desc: 'Phone number of the bookstore', required: false
  end
  def update
    @bookstore = Bookstore.find(params[:id])
    if @bookstore.update(bookstore_params)
      render json: @bookstore
    else
      render json: @bookstore.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/bookstores/:id
  api :DELETE, '/api/v1/bookstores/:id', 'Deletes an existing bookstore'
  param :id, :number, required: true, desc: 'ID of the bookstore'
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
