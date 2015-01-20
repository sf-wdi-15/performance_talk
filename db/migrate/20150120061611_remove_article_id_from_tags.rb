class RemoveArticleIdFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :article_id, :integer
  end
end
