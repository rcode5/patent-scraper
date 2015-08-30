class PatentQueriesController < ApplicationController

  before_action :set_patent_query, only: [:show, :destroy]

  def create
  end

  def show
    @patent_query = PatentQueryPresenter.new(@patent_query)
    respond_to do |format|
      format.html {}
      format.csv {
        (redirect_to patent_query_path(@patent_query), notice: "You must have processed patents before you can download anything" and return) if @patent_query.patents.empty?
      }
    end
  end

  def destroy
    @patent_query.destroy
    redirect_to root_path, notice: "The query #{@patent_query.name} has been removed"
  end

  private
  def set_patent_query
    @patent_query = PatentQuery.find(params[:id])
  end
  
end
