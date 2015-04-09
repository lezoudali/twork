module SearchHelper

  def render_results
    if search_present?
      render 'search/results'
    else
      flash[:info] = 'No Results Have Been Found'
    end
  end


end