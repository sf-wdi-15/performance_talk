class AddArticleIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :article_id, :integer
  end
end
