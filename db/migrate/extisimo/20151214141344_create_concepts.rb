class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :extisimo_concepts do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :extisimo_concepts, :name, unique: true, name: 'index_extisimo_name_as_unique'
  end
end
