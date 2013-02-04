require "java"
require "flying_saucer"


class ItemsController < ApplicationController
  
  
  
  
  #layout "Application/pdf"

  def hello
  #  @text = "Hello world"
    render_pdf("hello.pdf")
  end
    
 
  
  def render_pdf(filename)
    @html = render_to_string
    html_file = java.io.File.createTempFile(params[:action], ".html")
    html_file.delete_on_exit
    pdf_file = java.io.File.createTempFile(params[:action], ".pdf")
    pdf_file.delete_on_exit
    file_output_stream = java.io.FileOutputStream.new(html_file)
    file_output_stream.write(java.lang.String.new(@html).get_bytes("UTF-8"))
    file_output_stream.close
    renderer = org.xhtmlrenderer.pdf.ITextRenderer.new

    # if you put custom fonts in the lib/fonts folder under your Rails project, they will be available to your PDF document

    # Just specify  the correct font-family via CSS and Flying Saucer will use the correct font.

    fonts_path = Rails.root + "/lib/fonts/*.ttf"

    if File.exist?(fonts_path)
      font_resolver = renderer.getFontResolver()
      Dir[fonts_path].each do |file|
        font_resolver.add_font(file, true)
      end
    end

    renderer.set_document(html_file)
   # renderer.setDocument(new File(filename));
    renderer.layout
    renderer.createPDF(java.io.FileOutputStream.new(pdf_file), true)

    send_file pdf_file.path, :type => "application/pdf", :filename => filename, :disposition => "inline"
    
    
  end
  
  
  
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])


   # render_pdf('show.pdf')
    respond_to do |format|
     # format.html { render_pdf 'show.pdf' }
      format.html  # show.html.erb
    
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    
    
    @itemGroupDiscount  = Hash.new
    @itemGroupTax  = Hash.new
    
    @itemgroups = Itemgroup.all
    
     @itemgroups.each do |itmGrps|
       if itmGrps.update_disc_child then
          @itemGroupDiscount[itmGrps.name] = itmGrps.discount_per.to_s
       end  
       if itmGrps.update_tax_child then
          @itemGroupTax[itmGrps.name] = itmGrps.tax.to_s
       end  
     end

    gon.itemGroupDiscount = @itemGroupDiscount
    gon.itemGroupTax = @itemGroupTax

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    
    @itemGroupDiscount  = Hash.new
    @itemGroupTax  = Hash.new
    
    @itemgroups = Itemgroup.all
    
     @itemgroups.each do |itmGrps|
       if itmGrps.update_disc_child then
          @itemGroupDiscount[itmGrps.name] = itmGrps.discount_per.to_s
       end  
       if itmGrps.update_tax_child then
          @itemGroupTax[itmGrps.name] = itmGrps.tax.to_s
       end  
     end
    
     
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to :back } # items_url }
      format.json { head :no_content }
    end
  end
end
