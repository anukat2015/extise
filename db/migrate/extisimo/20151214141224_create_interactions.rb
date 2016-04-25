class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_interactions do |t|
      t.references :attachment, null: false
      t.references :session, null: false

      t.string :kind, null: false

      t.string :file, null: false, limit: 2048
      t.string :path, null: false, limit: 2048

      t.timestamps null: false

      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
    end

    # NOTE: provided attributes of available Mylyn context data from bugs.eclipse.org still
    # pose significant ambiguity and hence its impossible to specify a unique index here

    add_index :extisimo_interactions, :attachment_id
    add_index :extisimo_interactions, :session_id

    add_index :extisimo_interactions, :kind

    add_index :extisimo_interactions, :file
    add_index :extisimo_interactions, :path

    add_index :extisimo_interactions, :started_at
    add_index :extisimo_interactions, :finished_at
  end
end
