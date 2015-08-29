require 'csv'
class PatentsController < ApplicationController
  before_action :set_patent
      
  def show
    respond_to do |format|
      format.html {}
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"#{@patent.filename}\""
        headers['Content-Type'] ||= 'text/csv'
      }
    end
  end
  
  def set_patent
    @patent = PatentScraperService.find_or_create(params[:url])
  end
end
