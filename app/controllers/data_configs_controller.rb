class DataConfigsController < ApplicationController
  # GET /data_configs
  # GET /data_configs.json
  def index
    @data_configs = DataConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @data_configs }
    end
  end

  # GET /data_configs/1
  # GET /data_configs/1.json
  def show
    @data_config = DataConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data_config }
    end
  end

  # GET /data_configs/new
  # GET /data_configs/new.json
  def new
    @data_config = DataConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @data_config }
    end
  end

  # GET /data_configs/1/edit
  def edit
    @data_config = DataConfig.find(params[:id])
  end

  # POST /data_configs
  # POST /data_configs.json
  def create
    @data_config = DataConfig.new(params[:data_config])

    respond_to do |format|
      if @data_config.save
        format.html { redirect_to @data_config, notice: 'Data config was successfully created.' }
        format.json { render json: @data_config, status: :created, location: @data_config }
      else
        format.html { render action: "new" }
        format.json { render json: @data_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /data_configs/1
  # PUT /data_configs/1.json
  def update
    @data_config = DataConfig.find(params[:id])

    respond_to do |format|
      if @data_config.update_attributes(params[:data_config])
        format.html { redirect_to @data_config, notice: 'Data config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @data_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_configs/1
  # DELETE /data_configs/1.json
  def destroy
    @data_config = DataConfig.find(params[:id])
    @data_config.destroy

    respond_to do |format|
      format.html { redirect_to :back } #data_configs_url }
      format.json { head :no_content }
    end
  end
end
