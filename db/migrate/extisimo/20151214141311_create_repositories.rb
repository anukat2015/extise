class CreateRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_repositories do |t|
      t.references :project, null: false

      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :extisimo_repositories, :name, unique: true, name: 'index_extisimo_repositories_as_unique'
  end
end
