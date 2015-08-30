class PatentQueriesController < ApplicationController

  before_action :set_patent_query, only: [:show, :destroy]

  def create
  end

  def show
    @patent_query = PatentQueryPresenter.new(@patent_query)
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
