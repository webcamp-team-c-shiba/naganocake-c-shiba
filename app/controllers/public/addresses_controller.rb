class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @addresses = Address.where(customer_id: current_customer.id)
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      @addresses = Address.where(customer_id: current_customer.id)
      flash[:info] = "配送先が登録されました。"
      redirect_to addresses_path
    else
      @addresses = Address.where(customer_id: current_customer.id)
      render :index
    end
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先情報が更新されました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

private

  def address_params
    params.require(:address).permit(:postcode, :address, :name)
  end
  
end
