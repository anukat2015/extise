class CreateOrgEclipseBugsComments < ActiveRecord::Migration
  def change
    create_table :org_eclipse_bugs_comments do |t|
      t.references :bug, null: false
      t.references :author, null: false

      t.integer :commentid, null: false
      t.integer :comment_count, null: false
      t.string :who, null: false
      t.string :who_name, null: false
      t.datetime :bug_when, null: false
      t.text :thetext, null: false
      t.boolean :isprivate, null: false

      t.timestamps null: false
    end

    add_index :org_eclipse_bugs_comments, :bug_id
    add_index :org_eclipse_bugs_comments, :author_id

    add_index :org_eclipse_bugs_comments, :commentid
    add_index :org_eclipse_bugs_comments, :who
    add_index :org_eclipse_bugs_comments, :who_name
    add_index :org_eclipse_bugs_comments, :bug_when
  end
end
