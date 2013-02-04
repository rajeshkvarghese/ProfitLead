class JavascriptsController < ApplicationController  
    def populateInvoiceForm
      @addr_bill_tos = Customer.find(:all)
    end  
      
end
