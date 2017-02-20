class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.string :url
      t.integer :interval
      t.boolean :enabled
      t.datetime :last_run

      t.timestamps
    end
  end
end
