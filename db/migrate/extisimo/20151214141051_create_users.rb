class CreateUsers < ActiveRecord::Migration
  def change
    create_table :extisimo_users do |t|
      t.string :name, null: false
      t.string :names, null: false, array: true

      t.timestamps null: false
    end

    add_index :extisimo_users, :name, unique: true, name: 'index_extisimo_users_as_unique'

    add_index :extisimo_users, :names
  end
end
