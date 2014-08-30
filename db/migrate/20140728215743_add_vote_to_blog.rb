class AddVoteToBlog < ActiveRecord::Migration
  def up
    add_column :blogs, :like, :integer
    add_column :blogs, :dislike, :integer
  end

  def down
    remove_column :blogs, :like, :integer
    remove_column :blogs, :dislike, :integer
  end
end



