class GeneraljournalsController < ApplicationController
  # GET /generaljournals
  # GET /generaljournals.json
  def index
    @generaljournals = Generaljournal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generaljournals }
    end
  end

  # GET /generaljournals/1
  # GET /generaljournals/1.json
  def show
    @generaljournal = Generaljournal.find(params[:id])
    @journalentries = JournalEntry.find_all_by_generaljournal_id(@generaljournal.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generaljournal }
    end
  end

  # GET /generaljournals/new
  # GET /generaljournals/new.json
  def new
    @generaljournal = Generaljournal.new
    
    
     
     @customers = Ledger.all
    
    @hashCust  = Hash.new 
    @hashCustDrCr = Hash.new
    
    @customers.each do |cst|
      if cst.current_balance == nil or cst.current_balance == "" or cst.current_balance == 0.00 then
         if cst.opening_balance == nil or cst.opening_balance == "" or cst.opening_balance == 0.00 then
            @hashCust[cst.name] = 0.00
         else
            @hashCust[cst.name] = cst.opening_balance
         end  
       else
           @hashCust[cst.name] = cst.current_balance        
       end
     
      gon.hashCust = @hashCust
     
      @hashCustDrCr[cst.name] = cst.dr_cr
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generaljournal }
    end
  end

  # GET /generaljournals/1/edit
  def edit
    @generaljournal = Generaljournal.find(params[:id])
    @journalentries = JournalEntry.find_all_by_generaljournal_id(@generaljournal.id)
    
     
     @customers = Ledger.all
    
    @hashCust  = Hash.new 
    @hashCustDrCr = Hash.new
    
    @customers.each do |cst|
      if cst.current_balance == nil or cst.current_balance == "" or cst.current_balance == 0.00 then
         if cst.opening_balance == nil or cst.opening_balance == "" or cst.opening_balance == 0.00 then
            @hashCust[cst.name] = 0.00
         else
            @hashCust[cst.name] = cst.opening_balance
         end  
       else
           @hashCust[cst.name] = cst.current_balance        
       end
     
      gon.hashCust = @hashCust
     
      @hashCustDrCr[cst.name] = cst.dr_cr
    end
    
    
  end

  # POST /generaljournals
  # POST /generaljournals.json
  def create
    @generaljournal = Generaljournal.new(params[:generaljournal])

    respond_to do |format|
      if @generaljournal.save
        format.html { redirect_to @generaljournal, notice: 'Generaljournal was successfully created.' }
        format.json { render json: @generaljournal, status: :created, location: @generaljournal }
      else
        format.html { render action: "new" }
        format.json { render json: @generaljournal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generaljournals/1
  # PUT /generaljournals/1.json
  def update
    @generaljournal = Generaljournal.find(params[:id])
    
    
    
     
     @customers = Ledger.all
    
    @hashCust  = Hash.new 
    @hashCustDrCr = Hash.new
    
    @customers.each do |cst|
      if cst.current_balance == nil or cst.current_balance == "" or cst.current_balance == 0.00 then
         if cst.opening_balance == nil or cst.opening_balance == "" or cst.opening_balance == 0.00 then
            @hashCust[cst.name] = 0.00
         else
            @hashCust[cst.name] = cst.opening_balance
         end  
       else
           @hashCust[cst.name] = cst.current_balance        
       end
     
      gon.hashCust = @hashCust
     
      @hashCustDrCr[cst.name] = cst.dr_cr
    end
    
    

    respond_to do |format|
      if @generaljournal.update_attributes(params[:generaljournal])
        format.html { redirect_to @generaljournal, notice: 'Generaljournal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generaljournal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generaljournals/1
  # DELETE /generaljournals/1.json
  def destroy
    @generaljournal = Generaljournal.find(params[:id])
    @generaljournal.destroy

    respond_to do |format|
      format.html { redirect_to :back } #generaljournals_url }
      format.json { head :no_content }
    end
  end
end
