class ItemgroupsController < ApplicationController
  # GET /itemgroups
  # GET /itemgroups.json
  def index
    @itemgroups = Itemgroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @itemgroups }
    end
  end

  # GET /itemgroups/1
  # GET /itemgroups/1.json
  def show
    @itemgroup = Itemgroup.find(params[:id])
    @items = Item.find_all_by_group(@itemgroup.name)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @itemgroup }
    end
  end

  # GET /itemgroups/new
  # GET /itemgroups/new.json
  def new
    @itemgroup = Itemgroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @itemgroup }
    end
  end

  # GET /itemgroups/1/edit
  def edit
    @itemgroup = Itemgroup.find(params[:id])
    @items = Item.find_all_by_group(@itemgroup.name)
  end

  # POST /itemgroups
  # POST /itemgroups.json
  def create
    @itemgroup = Itemgroup.new(params[:itemgroup])

    respond_to do |format|
      if @itemgroup.save
        format.html { redirect_to @itemgroup, notice: 'Itemgroup was successfully created.' }
        format.json { render json: @itemgroup, status: :created, location: @itemgroup }
      else
        format.html { render action: "new" }
        format.json { render json: @itemgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /itemgroups/1
  # PUT /itemgroups/1.json
  def update
    @itemgroup = Itemgroup.find(params[:id])

    respond_to do |format|
      if @itemgroup.update_attributes(params[:itemgroup])
        format.html { redirect_to @itemgroup, notice: 'Itemgroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @itemgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itemgroups/1
  # DELETE /itemgroups/1.json
  def destroy
    @itemgroup = Itemgroup.find(params[:id])
    @itemgroup.destroy

    respond_to do |format|
      format.html { redirect_to :back } #itemgroups_url }
      format.json { head :no_content }
    end
  end
end
