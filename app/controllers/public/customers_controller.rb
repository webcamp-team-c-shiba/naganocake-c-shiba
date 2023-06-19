class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customers_path, notice: '会員情報が更新されました。'
    else
      render :edit
    end
  end

  def check
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customers_session_path, notice: '退会しました'
    else
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_last_name, :kana_first_name, :postcode, :address, :phone_number, :email, :is_deleted)
  end
end
