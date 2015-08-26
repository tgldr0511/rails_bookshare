class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :picture
      t.string :version
      t.integer :year

      t.timestamps null: false
    end
  end
end
