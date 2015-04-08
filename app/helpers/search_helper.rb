module SearchHelper

  def render_results
    if search_present?
      render 'search/results'
    else
      render text: 'No Results Have Been Found'
    end
  end


end