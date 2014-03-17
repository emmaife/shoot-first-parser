class AddLogToCombatParsers < ActiveRecord::Migration
  def change
    add_column :combat_parsers, :log, :string
  end
end
