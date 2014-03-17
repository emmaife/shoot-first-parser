class CreateCombatParsers < ActiveRecord::Migration
  def change
    create_table :combat_parsers do |t|
    


      t.timestamps
    end
  end
end
