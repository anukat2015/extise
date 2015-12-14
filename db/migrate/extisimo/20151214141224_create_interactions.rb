class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :extisimo_interactions do |t|
      t.references :attachment, null: false
      t.references :element, null: false
      t.references :session, null: false

      t.string :kind, null: false

      t.timestamps null: false

      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
    end

    add_index :extisimo_interactions, [:started_at, :element_id, :session_id], unique: true, name: 'index_extisimo_interactions_as_unique'

    add_index :extisimo_interactions, :attachment_id
    add_index :extisimo_interactions, :element_id
    add_index :extisimo_interactions, :session_id

    add_index :extisimo_interactions, :kind

    add_index :extisimo_interactions, :started_at
    add_index :extisimo_interactions, :finished_at
  end
end
