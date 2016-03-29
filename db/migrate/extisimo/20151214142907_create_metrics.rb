class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :extisimo_metrics do |t|
      t.string :target, null: false
      t.string :name, null: false

      t.string :file, null: false
      t.string :type, null: false

      t.timestamps null: false
    end

    add_index :extisimo_metrics, [:target, :name], unique: true, name: 'index_extisimo_metrics_as_unique'

    add_index :extisimo_metrics, :target
    add_index :extisimo_metrics, :name

    add_index :extisimo_metrics, :file
    add_index :extisimo_metrics, :type
  end
end
