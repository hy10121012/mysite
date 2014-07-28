class AddCoverImageToBlog < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :blogs, :cover
  end
end
