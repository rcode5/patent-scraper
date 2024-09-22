class CreateScrapedPatents < ActiveRecord::Migration[4.2]
  def change
    create_table :scraped_patents do |t|
      t.string :url, unique: true
      t.text :body
      t.text :root_query

      t.timestamps null: false
    end
  end

end
