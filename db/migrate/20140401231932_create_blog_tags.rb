class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.integer :tag_id, :blog_id
      t.timestamps
    end
  end
end
