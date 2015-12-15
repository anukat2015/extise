class CreatePosts < ActiveRecord::Migration
  def change
    create_table :extisimo_posts do |t|
      t.references :task, null: false
      t.references :author, null: false

      t.text :description, null: false

      t.timestamps null: false

      t.datetime :posted_at, null: false
      t.datetime :modified_at, null: false
    end

    add_index :extisimo_posts, [:posted_at, :author_id, :task_id], unique: true, name: 'index_extisimo_posts_as_unique'

    add_index :extisimo_posts, :task_id
    add_index :extisimo_posts, :author_id

    add_index :extisimo_posts, :posted_at
    add_index :extisimo_posts, :modified_at
  end
end
