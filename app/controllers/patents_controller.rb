require 'csv'
class PatentsController < ApplicationController
  before_action :set_patent

  def create
    respond_to do |format|
      format.html{ redirect_to patent_path(@patent) }
      format.json{ render json: @patent }
    end
  end
  
  def show
    respond_to do |format|
      format.html {}
      format.json {
        render json: @patent
      }
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"#{@patent.filename}\""
        headers['Content-Type'] ||= 'text/csv'
      }
    end
  end
  
  def set_patent
    patent = ScrapedPatent.where(id: params[:id]).take
    if patent
      @patent = PatentPresenter.new(patent)
    else
      @patent = PatentScraperService.find_or_create(params[:url])
    end
  end
end
