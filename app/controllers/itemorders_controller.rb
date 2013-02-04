class ItemordersController < ApplicationController
  # GET /itemorders
  # GET /itemorders.json
  def index
    @itemorders = Itemorder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @itemorders }
    end
  end

  # GET /itemorders/1
  # GET /itemorders/1.json
  def show
    @itemorder = Itemorder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @itemorder }
    end
  end

  # GET /itemorders/new
  # GET /itemorders/new.json
  def new
    @itemorder = Itemorder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @itemorder }
    end
  end

  # GET /itemorders/1/edit
  def edit
    @itemorder = Itemorder.find(params[:id])
  end

  # POST /itemorders
  # POST /itemorders.json
  def create
    @itemorder = Itemorder.new(params[:itemorder])

    respond_to do |format|
      if @itemorder.save
        format.html { redirect_to @itemorder, notice: 'Itemorder was successfully created.' }
        format.json { render json: @itemorder, status: :created, location: @itemorder }
      else
        format.html { render action: "new" }
        format.json { render json: @itemorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /itemorders/1
  # PUT /itemorders/1.json
  def update
    @itemorder = Itemorder.find(params[:id])

    respond_to do |format|
      if @itemorder.update_attributes(params[:itemorder])
        format.html { redirect_to @itemorder, notice: 'Itemorder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @itemorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itemorders/1
  # DELETE /itemorders/1.json
  def destroy
    @itemorder = Itemorder.find(params[:id])
    @itemorder.destroy

    respond_to do |format|
      format.html { redirect_to :back } #itemorders_url }
      format.json { head :no_content }
    end
  end
end
