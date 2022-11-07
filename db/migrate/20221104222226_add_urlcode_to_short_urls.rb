class AddUrlcodeToShortUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :url_code, :string
  end
end
