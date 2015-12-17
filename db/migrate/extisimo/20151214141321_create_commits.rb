class CreateCommits < ActiveRecord::Migration
  def change
    create_table :extisimo_commits do |t|
      t.references :repository, null: false
      t.references :author, null: false

      t.string :name, null: false, limit: 40

      t.timestamps null: false

      t.datetime :commited_at, null: false
    end

    add_index :extisimo_commits, [:repository_id, :name], unique: true, name: 'index_extisimo_commits_as_unique'

    add_index :extisimo_commits, :repository_id
    add_index :extisimo_commits, :author_id

    add_index :extisimo_commits, :name

    add_index :extisimo_commits, :commited_at
  end
end