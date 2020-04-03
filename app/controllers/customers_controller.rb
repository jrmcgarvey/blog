class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  layout 'customer_layout'

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    #respond_to do |format|
      if @customer.save
        #format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        #format.json { render :show, status: :created, location: @customer }
        flash.notice = "customer created"
        redirect_to @customer
      else
        #format.html { render :new }
        #format.json { render json: @customer.errors, status: :unprocessable_entity }
        flash.now.alert = @customer.errors.full_messages.to_sentence
        render :new
      end
    #end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    # respond_to do |format|
    #   if @customer.update(customer_params)
    #     format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @customer }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end
    @customer.update(customer_params)
    redirect_to @customer
    # if @customer.update(customer_params)
    #   flash.notice = "customer updated"
    #   redirect_to @customer
    # else
    #   flash.now.alert = @customer.errors.full_messages.to_sentence
    #   render :edit
    # end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone, :email)
    end

    def not_found(exception)
      Rails.logger.debug("not_found exception #{exception}")
      flash.alert = "The customer for id #{params[:id]} was not found."
      redirect_to customers_path
    end
end
