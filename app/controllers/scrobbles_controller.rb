class ScrobblesController < ApplicationController
  before_filter :authenticate_user, :only => :create

  # GET /scrobbles
  # GET /scrobbles.json
  def index
    @scrobbles = Scrobble.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scrobbles }
    end
  end

  # GET /scrobbles/1
  # GET /scrobbles/1.json
  def show
    @scrobble = Scrobble.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scrobble }
    end
  end

  # GET /scrobbles/new
  # GET /scrobbles/new.json
  def new
    @scrobble = Scrobble.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scrobble }
    end
  end

  # GET /scrobbles/1/edit
  def edit
    @scrobble = Scrobble.find(params[:id])
  end

  # POST /scrobbles
  # POST /scrobbles.json
  def create
    @scrobble = Scrobble.new(params[:scrobble])
    @scrobble.citation ||= Citation.find_in_params(params)
    @scrobble.user = @current_user

    respond_to do |format|
      if @scrobble.save
        format.html { redirect_to @scrobble, notice: 'Scrobble was successfully created.' }
        format.json { render json: @scrobble, status: :created, location: @scrobble }
      else
        format.html { render action: "new" }
        format.json { render json: @scrobble.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scrobbles/1
  # PUT /scrobbles/1.json
  def update
    @scrobble = Scrobble.find(params[:id])

    respond_to do |format|
      if @scrobble.update_attributes(params[:scrobble])
        format.html { redirect_to @scrobble, notice: 'Scrobble was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scrobble.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrobbles/1
  # DELETE /scrobbles/1.json
  def destroy
    @scrobble = Scrobble.find(params[:id])
    @scrobble.destroy

    respond_to do |format|
      format.html { redirect_to scrobbles_url }
      format.json { head :no_content }
    end
  end

  private
  
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
  end
end

