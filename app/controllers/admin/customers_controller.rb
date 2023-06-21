class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page]).per(10)
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "#{@customer.last_name}#{@customer.first_name}さんの会員情報が更新されました。"
      redirect_to admin_customer_path(params[:id])
    else 
      flash[:danger] = "会員情報の更新に失敗しました"
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :postcode, :address, :phone_number, :is_deleted)
  end
  
end
