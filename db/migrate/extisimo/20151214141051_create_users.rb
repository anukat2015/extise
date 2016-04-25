class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_users do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :extisimo_users, :name, unique: true, name: 'index_extisimo_users_as_unique'
  end
end
