class AddLikeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :like_count, :integer
  end
end
