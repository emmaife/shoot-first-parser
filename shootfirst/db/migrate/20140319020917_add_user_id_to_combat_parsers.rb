class AddUserIdToCombatParsers < ActiveRecord::Migration
  def change
    add_column :combat_parsers, :user_id, :integer
  end
end
