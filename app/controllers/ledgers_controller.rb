class LedgersController < ApplicationController
  before_filter :authenticate_user!
  
add_breadcrumb "home", :root_path
#add_breadcrumb "my", :my_path
   
  
  # GET /ledgers
  # GET /ledgers.json 
  def index
    

    
    
  if params[:groupP] != nil then  
     @ledgers = Ledger.find_all_by_group(params[:groupP])
  else
    @ledgers = Ledger.all
  end  

add_breadcrumb "index", ledgers_path


    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ledgers }
    end
  end

  # GET /ledgers/1
  # GET /ledgers/1.json
  def show
    @ledger = Ledger.find(params[:id])

    add_breadcrumb "index", ledgers_path
    add_breadcrumb "show", ledger_path, :title => "Back to the Index"
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { :json => @ledgers  }
    end
  end

  # GET /ledgers/new
  # GET /ledgers/new.json
  def new
    @ledger = Ledger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { :json => @ledgers  }
    end
  end

  # GET /ledgers/1/edit
  def edit
    @ledger = Ledger.find(params[:id])
  end

  # POST /ledgers
  # POST /ledgers.json
  def create
    @ledger = Ledger.new(params[:ledger])

    respond_to do |format|
      if @ledger.save
        format.html { redirect_to @ledger, notice: 'Ledger was successfully created.' }
        format.json { render json: @ledger, status: :created, location: @ledger }
      else
        format.html { render action: "new" }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ledgers/1
  # PUT /ledgers/1.json
  def update
    @ledger = Ledger.find(params[:id])

    respond_to do |format|
      if @ledger.update_attributes(params[:ledger])
        format.html { redirect_to @ledger, notice: 'Ledger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledgers/1
  # DELETE /ledgers/1.json
  def destroy
    @ledger = Ledger.find(params[:id])
    @ledger.destroy

    respond_to do |format|
      format.html { redirect_to :back } #ledgers_url }
      format.json { head :no_content }
    end
  end
end
