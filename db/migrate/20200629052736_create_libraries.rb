class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :code
      t.string :key
      t.string :address
      t.string :tel
      t.string :url

      t.timestamps
    end
  end
end
