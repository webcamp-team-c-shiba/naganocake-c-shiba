class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:success] = "会員情報が更新されました。"
      redirect_to customers_path
    else
      flash.now[:danger] = '未記入項目があります'
      render :edit
    end
  end

  def check
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:danger] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_last_name, :kana_first_name, :postcode, :address, :phone_number, :email, :is_deleted)
  end
end
