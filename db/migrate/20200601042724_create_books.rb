class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :url
      t.text :description
      t.string :thumbnail_url
      t.integer :status

      t.timestamps
    end
  end
end
