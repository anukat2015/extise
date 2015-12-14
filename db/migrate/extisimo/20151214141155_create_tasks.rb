class CreateTasks < ActiveRecord::Migration
  def change
    create_table :extisimo_tasks do |t|
      t.references :reporter, null: false
      t.references :assignee, null: false
      t.references :project, null: false

      t.string :classification, null: false
      t.string :keywords, null: false, array: true
      t.text :description, null: false
      t.string :status, null: false
      t.string :resolution, null: false
      t.string :severity, null: false
      t.string :priority, null: false
      t.boolean :confirmed, null: false
      t.string :platform, null: false
      t.string :operating_system, null: false
      t.string :project_version, null: false
      t.string :project_milestone, null: false
      t.string :cc, null: false, array: true

      t.integer :votes_count, null: false

      t.timestamps null: false

      t.datetime :reported_at, null: false
      t.datetime :modified_at, null: false
    end

    add_index :extisimo_tasks, [:reported_at, :reporter_id], unique: true, name: 'index_extisimo_tasks_as_unique'

    add_index :extisimo_tasks, :classification

    add_index :extisimo_tasks, :status
    add_index :extisimo_tasks, :resolution
    add_index :extisimo_tasks, :severity
    add_index :extisimo_tasks, :priority

    add_index :extisimo_tasks, :confirmed

    add_index :extisimo_tasks, :votes_count

    add_index :extisimo_tasks, :reported_at
    add_index :extisimo_tasks, :modified_at
  end
end
