class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.where(customer_id: current_customer.id)
    @address = Address.new
  end

  def edit
    
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    @addresses = Address.where(customer_id: current_customer.id)
    redirect_to public_addresses_path
  end
  
  def update
  end

  def destroy
    byebug
    address = Address.find(params[:id])
    address.destroy
    redirect_to public_addresses_path
  end

private

  def address_params
    params.require(:address).permit(:postcode, :address, :name)
  end
  
end
