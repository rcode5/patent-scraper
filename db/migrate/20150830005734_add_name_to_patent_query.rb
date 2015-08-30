class AddNameToPatentQuery < ActiveRecord::Migration
  def change
    add_column :patent_queries, :name, :string
  end
end
