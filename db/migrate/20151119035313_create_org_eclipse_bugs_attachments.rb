class CreateOrgEclipseBugsAttachments < ActiveRecord::Migration
  def change
    create_table :org_eclipse_bugs_attachments do |t|
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
      t.string :attacher_name, null: false
      t.boolean :isobsolete, null: false
      t.boolean :ispatch, null: false
      t.boolean :isprivate, null: false

      t.timestamps null: false
    end

    add_index :org_eclipse_bugs_attachments, :bug_id
    add_index :org_eclipse_bugs_attachments, :submitter_id

    add_index :org_eclipse_bugs_attachments, :attachid
    add_index :org_eclipse_bugs_attachments, :date
    add_index :org_eclipse_bugs_attachments, :delta_ts
    add_index :org_eclipse_bugs_attachments, :filename
    add_index :org_eclipse_bugs_attachments, :type
    add_index :org_eclipse_bugs_attachments, :size
    add_index :org_eclipse_bugs_attachments, :attacher
    add_index :org_eclipse_bugs_attachments, :attacher_name
  end
end
