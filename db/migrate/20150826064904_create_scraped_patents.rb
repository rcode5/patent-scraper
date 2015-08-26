class CreateScrapedPatents < ActiveRecord::Migration
  def change
    create_table :scraped_patents do |t|
      t.string :url
      t.text :body
      t.text :root_query

      t.timestamps null: false
    end
  end
end
