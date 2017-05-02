class UsersController < ApplicationController

  skip_before_action :require_login, only: [:create, :index]
  before_action :require_correct_user, only: [:index]

  def index
  	@user = User.find(current_user)
  	@purchases = Purchase.where(buyer_id: current_user)
  	@sales = Purchase.where(user_id: current_user)
  	@my_items = Item.where(user_id: current_user)
  	@available = @my_items.where.not(id: @sales.select(:item_id))

  	@math_sales = Item.where(id: @sales.select(:item_id))
  	@math_sales_2 = @math_sales.select(:price)
  	@math_sales_3 = @math_sales_2.sum(:price)

  	@math_purchases = Item.where(id: @purchases.select(:item_id))
  	@math_purchases_2 = @math_purchases.select(:price)
  	@math_purchases_3 = @math_purchases_2.sum(:price)
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  private

    def require_correct_user
      if current_user != User.find(params[:id])
        redirect_to :root
      end
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
