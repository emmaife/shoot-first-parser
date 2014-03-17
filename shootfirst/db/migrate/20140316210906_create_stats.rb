class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :total_dmg
      t.integer :avg_dmg
      t.integer :dmg_pct
    end
  end
end
