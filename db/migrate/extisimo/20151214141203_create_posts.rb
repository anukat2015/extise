class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_posts do |t|
      t.references :task, null: false
      t.references :author, null: false

      t.text :description, null: false

      t.timestamps null: false

      t.datetime :submitted_at, null: false
      t.datetime :modified_at, null: false
    end

    add_index :extisimo_posts, [:submitted_at, :author_id, :task_id], unique: true, name: 'index_extisimo_posts_as_unique'

    add_index :extisimo_posts, :submitted_at
    add_index :extisimo_posts, :modified_at
  end
end
