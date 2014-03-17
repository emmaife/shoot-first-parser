class CreateAbilityStats < ActiveRecord::Migration
  def change
    create_table :ability_stats do |t|
      t.integer :ability_id
      t.integer :stat_id
    end
  end
end
