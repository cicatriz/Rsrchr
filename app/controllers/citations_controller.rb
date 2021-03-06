class CitationsController < ApplicationController
  before_filter :authenticate_user, :only => [:create]

  autocomplete :citation, :title, :full => true
  

  # GET /citations
  # GET /citations.json
  def index
    @citations = Citation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @citations }
    end
  end

  # GET /citations/1
  # GET /citations/1.json
  def show
    if params[:citekey]
      @citation = Citation.find_by_citekey(params[:citekey])
    else
      @citation = Citation.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @citation }
    end
  end

  # GET /citations/new
  # GET /citations/new.json
  def new
    @citation = Citation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @citation }
    end
  end

  # GET /citations/1/edit
  def edit
    @citation = Citation.find(params[:id])
  end

  # POST /citations
  # POST /citations.json
  def create

    @citation = Citation.create_from_bibtex(params[:bibtex], @current_user)

    unless params[:hashkey].nil?
      @citation.pdfhashes.create(:hashkey => params[:hashkey])
    end

    respond_to do |format|
      format.html { redirect_to @citation }
      format.json { render json: @citation, status: :created, location: @citation }
    end
  end

  # PUT /citations/1
  # PUT /citations/1.json
  def update
    @citation = Citation.find(params[:id])

    respond_to do |format|
      if @citation.update_attributes(params[:citation])
        format.html { redirect_to @citation, notice: 'Citation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @citation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /citations/1
  # DELETE /citations/1.json
  def destroy
    @citation = Citation.find(params[:id])
    @citation.destroy

    respond_to do |format|
      format.html { redirect_to citations_url }
      format.json { head :no_content }
    end
  end

  private
  
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
  end
end
