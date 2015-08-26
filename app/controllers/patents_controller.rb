class PatentsController < ApplicationController
  def scrape
    @patent = PatentScraperService.find(params[:url])
    # @data = scraper.data
    # @page = scraper.page
    render 'show'
  end
end
