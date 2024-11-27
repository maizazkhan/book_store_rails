class BookstoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookstore, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource # This will use CanCanCan to authorize actions

  # GET /bookstores
  def index
    @bookstores = Bookstore.all
  end

  # GET /bookstores/:id
  def show
  end

  # GET /bookstores/new
  def new
    @bookstore = Bookstore.new
  end

  # POST /bookstores
  def create
    @bookstore = Bookstore.new(bookstore_params)
    if @bookstore.save
      redirect_to @bookstore, notice: 'Bookstore was successfully created.'
    else
      render :new
    end
  end

  # GET /bookstores/:id/edit
  def edit
  end

  # PATCH/PUT /bookstores/:id
  def update
    if @bookstore.update(bookstore_params)
      redirect_to @bookstore, notice: 'Bookstore was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookstores/:id
  def destroy
    @bookstore.destroy
    redirect_to bookstores_url, notice: 'Bookstore was successfully destroyed.'
  end

  private

  # Set the bookstore object before actions that require it
  def set_bookstore
    @bookstore = Bookstore.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def bookstore_params
    params.require(:bookstore).permit(:name, :address, :phone)
  end
end
