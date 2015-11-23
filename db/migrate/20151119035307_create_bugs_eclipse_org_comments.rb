class CreateBugsEclipseOrgComments < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_comments do |t|
      t.references :bug, null: false
      t.references :author, null: false

      t.integer :commentid, null: false
      t.integer :comment_count, null: false
      t.string :who, null: false
      t.string :who_name, null: true
      t.datetime :bug_when, null: false
      t.text :thetext, null: false
      t.boolean :isprivate, null: false

      t.timestamps null: false
    end

    add_index :bugs_eclipse_org_comments, :bug_id
    add_index :bugs_eclipse_org_comments, :author_id

    add_index :bugs_eclipse_org_comments, :commentid, unique: true, name: 'index_bugs_eclipse_org_comments_as_unique'
    add_index :bugs_eclipse_org_comments, :who
    add_index :bugs_eclipse_org_comments, :who_name
    add_index :bugs_eclipse_org_comments, :bug_when
  end
end
