class CustomersController < ApplicationController
    # GET /customers
    # GET /customers.json
   
   def index
    @customers = Customer.all     
    
  end
  
  def show
    @customer = Customer.find(params[:id])
  #  respond_to do |format|
   #     format.js {}
   # end
  end 
  
  
  def new
        @customer = Customer.new
  end
  
  def create
     @customer = Customer.new(params[:customer])
     
     respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update    
     @customer = Customer.find(params[:id])
      respond_to do |format|
        if @customer.update_attributes(params[:customer])
          format.html { redirect_to @customer, notice: 'Item was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
     end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to :back #customers_path, :notice => "Selected customer has been deleted!"
  
  end
  
end
