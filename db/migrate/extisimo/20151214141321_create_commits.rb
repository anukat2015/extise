class CreateCommits < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_commits do |t|
      t.references :repository, null: false
      t.references :author, null: false

      t.string :identifier, null: false, limit: 40

      t.timestamps null: false

      t.datetime :submitted_at, null: false
    end

    add_index :extisimo_commits, [:repository_id, :identifier], unique: true, name: 'index_extisimo_commits_as_unique'

    add_index :extisimo_commits, :repository_id
    add_index :extisimo_commits, :author_id

    add_index :extisimo_commits, :identifier

    add_index :extisimo_commits, :submitted_at
  end
end
