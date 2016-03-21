class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :extisimo_metrics do |t|
      t.string :name, null: false
      t.string :target, null: false

      t.string :path, null: false

      t.timestamps null: false
    end

    add_index :extisimo_metrics, :name, unique: true, name: 'index_extisimo_metrics_as_unique'

    add_index :extisimo_metrics, :target

    add_index :extisimo_metrics, :path
  end
end
