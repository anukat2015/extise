class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_attachments do |t|
      t.references :bug, null: false
      t.references :submitter, null: false

      t.integer :attachid, null: false
      t.datetime :date, null: false
      t.datetime :delta_ts, null: false
      t.text :desc, null: false
      t.string :filename, null: false
      t.string :type, null: false
      t.integer :size, null: false
      t.string :attacher, null: false
      t.string :attacher_name, null: true
      t.boolean :isobsolete, null: false
      t.boolean :ispatch, null: false
      t.boolean :isprivate, null: false

      t.timestamps null: false
    end

    add_index :bugs_eclipse_org_attachments, :bug_id
    add_index :bugs_eclipse_org_attachments, :submitter_id

    add_index :bugs_eclipse_org_attachments, :attachid, unique: true, name: 'index_bugs_eclipse_org_attachments_as_unique'
    add_index :bugs_eclipse_org_attachments, :date
    add_index :bugs_eclipse_org_attachments, :delta_ts
    add_index :bugs_eclipse_org_attachments, :filename
    add_index :bugs_eclipse_org_attachments, :type
    add_index :bugs_eclipse_org_attachments, :size
    add_index :bugs_eclipse_org_attachments, :attacher
    add_index :bugs_eclipse_org_attachments, :attacher_name
  end
end
