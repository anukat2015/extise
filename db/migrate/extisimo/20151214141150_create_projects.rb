class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_projects do |t|
      t.string :product, null: false
      t.string :component, null: false

      t.timestamps null: false
    end

    add_index :extisimo_projects, [:product, :component], unique: true, name: 'index_extisimo_projects_as_unique'

    add_index :extisimo_projects, :product
    add_index :extisimo_projects, :component
  end
end
