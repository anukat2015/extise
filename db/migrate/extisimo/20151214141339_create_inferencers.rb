class CreateInferencers < ActiveRecord::Migration
  def change
    create_table :extisimo_inferencers do |t|
      t.string :name, null: false
      t.string :target, null: false

      t.timestamps null: false
    end

    add_index :extisimo_inferencers, :name, unique: true, name: 'index_extisimo_inferencers_as_unique'

    add_index :extisimo_inferencers, :target
  end
end
