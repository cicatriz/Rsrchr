class UserCitationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def create
    @citation = Citation.find(params[:user_citation][:citation_id])
    current_user.add_citation!(@citation)
    redirect_to @citation
  end

  def destroy
    @citation = UserCitation.find(params[:id]).citation
    current_user.remove_citation!(@citation)
    redirect_to @citation
  end

  def index
    @user = User.find(params[:user_id])
    bibtex = @user.citations.collect { |c| c.bibtex }.join("<br /><br />")
    render :text => bibtex
  end

end
