class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :description
      t.string :img_url

      t.timestamps
    end
  end
end
