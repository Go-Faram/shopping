class OrdersController < ApplicationController
  include CurrentCart
  #layout "consolelayout" ,only: [:index]
  before_action :signed_in_user, only: [:new,:index,:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = @current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if signed_in?
        if @cart.line_items.empty?
          redirect_to store_url, notice: "Your cart is empty"
          return
        end
        # @current_user=current_user
        @order =Order.new
    else
      redirect_to cart_path(Cart.find(session[:cart_id])), notice:"请登录"
  end

  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
     @current_user=current_user
    # @order = Order.new(order_params)
    @order=current_user.orders.create(order_params)
     @order.add_line_items_from_cart(@cart)
    # @order=@current_user.orders(order_params)
    # @current_user.orders.create(@order


    respond_to do |format|
      if @order.save
        # format.html { redirect_to @order, notice: 'Order was successfully created.' }
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to store_url, notice:
                      'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
