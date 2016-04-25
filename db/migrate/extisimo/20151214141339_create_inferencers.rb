class CreateInferencers < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_inferencers do |t|
      t.string :target, null: false
      t.string :name, null: false

      t.string :file, null: false
      t.string :type, null: false

      t.timestamps null: false
    end

    add_index :extisimo_inferencers, [:target, :name], unique: true, name: 'index_extisimo_inferencers_as_unique'

    add_index :extisimo_inferencers, :target
    add_index :extisimo_inferencers, :name

    add_index :extisimo_inferencers, :file
    add_index :extisimo_inferencers, :type
  end
end
