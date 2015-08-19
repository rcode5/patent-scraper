class PatentsController < ApplicationController
  def scrape
    scraper = PatentScraperService.new(params[:url])
    @data = scraper.data
    @page = scraper.page
    render 'show'
  end
end
