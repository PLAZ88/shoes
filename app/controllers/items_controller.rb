class ItemsController < ApplicationController

  def create
  	@user = User.find(current_user)
  	@item = Item.new(item_params)
    if @item.save
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to :back
    end
  end

  def purchase
   	@user = User.find(current_user)
  	@purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to "/shoes"
    else
      flash[:errors] = @purchase.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  	@user = User.find(current_user)
  	@item = Item.find(params[:id])
    @item.destroy if @item.user === current_user
    redirect_to "/dashboard/#{@user.id}"
  end

  def show
  	@user = User.find(current_user)
    @purchases = Purchase.select(:item_id)
    @items = Item.where.not(id: @purchases)
  end


  private

	def item_params
	  params.require(:item).permit(:product, :price).merge(user: current_user)
	end

	def purchase_params
	  params.require(:purchase).permit(:user_id, :buyer_id, :item_id)
	end

end
