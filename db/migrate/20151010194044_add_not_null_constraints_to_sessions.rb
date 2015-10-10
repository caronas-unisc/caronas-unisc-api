class AddNotNullConstraintsToSessions < ActiveRecord::Migration
  def change
    change_column :sessions, :user_id, :string, null: false
    change_column :sessions, :token, :string, null: false
  end
end
