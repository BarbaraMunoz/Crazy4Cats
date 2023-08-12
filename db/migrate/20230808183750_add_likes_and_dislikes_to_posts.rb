class AddLikesAndDislikesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes, :integer
    add_column :posts, :dislikes, :integer
  end
end
