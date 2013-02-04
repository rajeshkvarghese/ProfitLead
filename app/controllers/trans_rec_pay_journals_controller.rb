class TransRecPayJournalsController < ApplicationController
  # GET /trans_rec_pay_journals
  # GET /trans_rec_pay_journals.json
  def index
    
    #@trans_rec_pay_journals = TransRecPayJournal.all
    
    trans = params[:trans]
    acchead = params[:acchead]
    
    if trans == 'rec' then
      trans = 'Dr'
    else
      trans = 'Cr'
    end

    @trans_rec_pay_journals  = TransRecPayJournal.find(:all, :conditions => ["dr_cr = ? and account_head = ?", trans, acchead])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trans_rec_pay_journals }
    end
  end

  # GET /trans_rec_pay_journals/1
  # GET /trans_rec_pay_journals/1.json
  def show
    @trans_rec_pay_journal = TransRecPayJournal.find(params[:id])
    
    
    
     @journalentries = JournalEntry.find(:all,  :conditions => ["trans_rec_pay_journal_id = ? and account_head != ?", @trans_rec_pay_journal.id, @trans_rec_pay_journal.account_head])
    if @trans_rec_pay_journal.dr_cr == "Cr" then
      @trans = "pay"
    else
      @trans = "rec"  
    end
    
    #@customers= Customer.pluck(:name)
    #@curBalance = Customer.pluck(:current_balance)
    
     @customers = Ledger.all
    
    @hashCust = Hash.new
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
      @hashCustDrCr[cst.name] = cst.dr_cr
    end
    
    
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trans_rec_pay_journal }
    end
  end

  # GET /trans_rec_pay_journals/new
  # GET /trans_rec_pay_journals/new.json
  def new
    @trans_rec_pay_journal = TransRecPayJournal.new
    
   # @customers= Customer.pluck(:name)
    #@curBalance = Customer.pluck(:current_balance)
    
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
      format.json { render json: @trans_rec_pay_journal }
    end
  end

  # GET /trans_rec_pay_journals/1/edit
  def edit
    @trans_rec_pay_journal = TransRecPayJournal.find(params[:id])
    @journalentries = JournalEntry.find_all_by_trans_rec_pay_journal_id(@trans_rec_pay_journal.id)
    if @trans_rec_pay_journal.dr_cr == "Cr" then
      @trans = "pay"
    else
      @trans = "rec"  
    end
    
    #@customers= Customer.pluck(:name)
    #@curBalance = Customer.pluck(:current_balance)
    
     @customers = Ledger.all
    
    @hashCust = Hash.new
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
      @hashCustDrCr[cst.name] = cst.dr_cr
    end
  end

  # POST /trans_rec_pay_journals
  # POST /trans_rec_pay_journals.json
  def create
    @trans_rec_pay_journal = TransRecPayJournal.new(params[:trans_rec_pay_journal])

    respond_to do |format|
      if @trans_rec_pay_journal.save
        format.html { redirect_to @trans_rec_pay_journal, notice: 'Trans rec pay journal was successfully created.' }
        format.json { render json: @trans_rec_pay_journal, status: :created, location: @trans_rec_pay_journal }
      else
        format.html { render action: "new" }
        format.json { render json: @trans_rec_pay_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trans_rec_pay_journals/1
  # PUT /trans_rec_pay_journals/1.json
  def update
    @trans_rec_pay_journal = TransRecPayJournal.find(params[:id])

    respond_to do |format|
      if @trans_rec_pay_journal.update_attributes(params[:trans_rec_pay_journal])
        format.html { redirect_to @trans_rec_pay_journal, notice: 'Trans rec pay journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trans_rec_pay_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trans_rec_pay_journals/1
  # DELETE /trans_rec_pay_journals/1.json
  def destroy
    @trans_rec_pay_journal = TransRecPayJournal.find(params[:id])
    @trans_rec_pay_journal.destroy

    respond_to do |format|
      format.html { redirect_to :back } #trans_rec_pay_journals_url }
      format.json { head :no_content }
    end
  end
end
