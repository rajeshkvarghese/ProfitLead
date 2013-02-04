class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    @itemorders = Itemorder.find_all_by_invoice_id(@invoice.id)
    
    @total = 0.0
    @itemorders.each do |lineT|
      @total = @total + lineT.final_total.to_i      
    end
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new 
    
  
  
   custArr = []
   @cust = Ledger.all #pluck([:name, :addr_bill_to])
   @cust.each do |cust|
      custArr.push cust.name << "^" << cust.office_mobile_no << "^"<< cust.office_email_id << "^"<< cust.office_addr_bill_to << "^"<< cust.office_city << "^"<< cust.office_district << "^"<< cust.office_state << "^"<< cust.office_country<< "^"<< cust.office_pin_code
   end
   
   gon.customers = custArr 
    
    
   itmArr = []
   @itm = Item.all #pluck([:name, :addr_bill_to])
   @itm.each do |itm|
      itmArr.push itm.code << "^" << itm.name << "^"<< itm.base_unit<< "^"<< itm.sales_rate.to_s << "^"<< itm.discount_percentage.to_s  << "^"<< if itm.vat_account.to_s != "" then itm.vat_account.to_s.split("VAT")[1].to_f else 0.00 end  << "^"<< itm.quantity_on_hand.to_s
   end
    
  gon.items = itmArr
  
  
    
 #  itmGrpArr = []
 #  @itmGrp = Itemgroup.all #pluck([:name, :addr_bill_to])
 #  @itmGrp.each do |itmGrp|
  #    itmGrpArr.push itmGrp.name << "^" << itmGrp.update_disc_child << "^"<< itmGrp.discount_per.to_s << "^"<< itmGrp.update_tax_child << "^"<< itmGrp.tax.to_s
 #  end
    
#  gon.itemgroups = itmGrpArr
  
   # for a in @cust
      
   # end
    
    @invoice = Invoice.new    
    #@customer = Customer.all.name
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
    
    
    gon.current_invoice_id =  @invoice.id
    
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
    @itemorders = Itemorder.find_all_by_invoice_id(@invoice.id)
    gon.current_invoice_id =  @invoice.id
    
   custArr = []
   @cust = Ledger.all #pluck([:name, :addr_bill_to])
   @cust.each do |cust|
      custArr.push cust.name << "^" << cust.office_mobile_no << "^"<< cust.office_email_id << "^"<< cust.office_addr_bill_to << "^"<< cust.office_city << "^"<< cust.office_district << "^"<< cust.office_state << "^"<< cust.office_country<< "^"<< cust.office_pin_code
   end
   
     gon.customers = custArr
   
   itmArr = []
   @itm = Item.all #pluck([:name, :addr_bill_to])
   @itm.each do |itm|
     # itmArr.push itm.code << "^" << itm.name << "^"<< itm.sales_rate.to_s<< "^"<< itm.discount_percentage.to_s
      itmArr.push itm.code << "^" << itm.name << "^"<< itm.base_unit<< "^"<< itm.sales_rate.to_s << "^"<< itm.discount_percentage.to_s  << "^"<< if itm.vat_account.to_s != "" then itm.vat_account.to_s.split("VAT")[1].to_f else 0.00 end  << "^"<< itm.quantity_on_hand.to_s
   end
     gon.items = itmArr   
  end
  

  
 
  
  

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to :back } #invoices_url }
      format.json { head :no_content }
    end
  end
end
