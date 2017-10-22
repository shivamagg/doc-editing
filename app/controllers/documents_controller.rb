class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  include TextChange
  
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @edits = @document.edits.reverse
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
    unless @document.is_available?
      respond_to do |format|
        format.html { redirect_to @document, notice: 'Document is currently unavailable for editing' }
        format.json { render json: {error: 'Document is currently unavailable for editing'}, status: :unprocessable_entity }
      end
    else
      @document.is_not_available!
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    old_text = @document.text
    new_text = params[:document][:text]
    @change = text_change old_text, new_text
    
    unless @change[:result] == 'no change'
      edit_params = @change[:result]
      edit_params[:document_id] = @document.id
      edit_params[:user_id] = current_user.id.to_i
    end

    respond_to do |format|
      if @document.update(document_params)
        @edit = Edit.create(edit_params) unless @change[:result] == 'no change'
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end

    @document.is_available!
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.fetch(:document).permit(:title, :text)
    end
end
