class SearchController < ApplicationController
  
  include SearchHelper

  helper_method :search_present?

  def search
    @searches = Search.for(params[:keyword])
    if search_present?
      render_results 
    else
      flash[:notice] = "No Results Were Found"
      redirect_to root_path
    end
  end

  private

  def search_present?
    !(@searches.all? {|k,v| v.empty?})
  end

end