class CreatePatentQueries < ActiveRecord::Migration
  def change
    create_table :patent_queries do |t|
      t.string :url, unique: true
      t.text :links

      t.timestamps null: false
    end
  end

end
