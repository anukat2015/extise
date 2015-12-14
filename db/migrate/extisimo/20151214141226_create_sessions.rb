class CreateSessions < ActiveRecord::Migration
  def change
    create_table :extisimo_sessions do |t|
      t.references :user, null: false

      t.references :original_commit
      t.references :revision_commit, null: false

      t.timestamps null: false

      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
    end

    add_index :extisimo_sessions, :revision_commit_id, unique: true, name: 'index_extisimo_sessions_as_unique'

    add_index :extisimo_sessions, :user_id

    add_index :extisimo_sessions, :started_at
    add_index :extisimo_sessions, :finished_at
  end
end
