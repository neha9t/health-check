class AddIsSiteOnlineToChecks < ActiveRecord::Migration[5.0]
  def change
    add_column :checks, :is_site_online, :string
  end
end
