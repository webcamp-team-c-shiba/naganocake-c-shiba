class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to 'customers/show', notice: '会員情報が更新されました。'
    else
      render :'customers/edit'
    end
  end 
  
  def check
    @customer = Customer.find(params[:id])
  end 
  
  def withdrawal
    @customer = Customer.find(params[:id])
  end 
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:kana_last_name,:kana_first_name,:postcode,:address,:phone_number,:email,:is_deleted)
  end
  
end
