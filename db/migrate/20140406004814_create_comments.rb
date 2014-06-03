class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :name
      t.integer :blog_id

      t.timestamps
    end
  end
end
