class CreateElements < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_elements do |t|
      t.references :commit, null: false

      t.string :file, null: false, limit: 2048
      t.string :path, null: false, limit: 2048

      t.integer :offset, null: false
      t.integer :length, null: false

      t.integer :line, null: false

      t.timestamps null: false
    end

    add_index :extisimo_elements, [:commit_id, :file, :path], unique: true, name: 'index_extisimo_elements_as_unique'

    add_index :extisimo_elements, :commit_id

    add_index :extisimo_elements, :file
    add_index :extisimo_elements, :path
  end
end
