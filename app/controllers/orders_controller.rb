class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash.notice = "The order record was successfully created."
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      flash.notice = "The order record was successfully updated."
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    flash.notice = "The order was successfully deleted."
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:product_name,:product_count,:customer_id)
  end

  def set_order
    @order=Order.find(params[:id])
  end
end
