class SearchController < ApplicationController
  
  include SearchHelper

  helper_method :search_present?, :render_results

  def search
    @search = Search.for(params[:keyword])
    if search_present?
      @results = prioritize(@search)
      # binding.pry
      render_results 
    else
      flash[:notice] = "No Results Were Found"
      redirect_to root_path
    end
  end


  private

  def search_present?
    !(@search.all? {|k,v| v.empty?})
  end

  def prioritize(nested_hash)
    arr = nested_hash.sort_by {|k,v| v.count}.reverse
    # remove_keys(arr)
  end

  # def remove_keys(arr)
  #   arr.each_with_index do |ele,ind|
  #     arr.delete_at(ind) if ele.is_a?(Symbol)
  #   end
  # end

end