class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :extisimo_attachments do |t|
      t.references :task, null: false
      t.references :author, null: false

      t.string :file, null: false, limit: 2048
      t.string :type, null: false

      t.text :description, null: false

      t.timestamps null: false

      t.datetime :submitted_at, null: false
      t.datetime :modified_at, null: false
    end

    add_index :extisimo_attachments, [:attached_at, :author, :task], unique: true, name: 'index_extisimo_attachments_as_unique'

    add_index :extisimo_attachments, :task_id
    add_index :extisimo_attachments, :author_id

    add_index :extisimo_attachments, :file
    add_index :extisimo_attachments, :type

    add_index :extisimo_posts, :attached_at
    add_index :extisimo_posts, :modified_at
  end
end
