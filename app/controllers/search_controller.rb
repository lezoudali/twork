class SearchController < ApplicationController
  def search
    result = Search.for(params[:keyword])
    binding.pry
    render text: result.to_s
  end


end