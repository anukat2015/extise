class CreateOrgEclipseBugsBugs < ActiveRecord::Migration
  def change
    create_table :org_eclipse_bugs_bugs do |t|
      t.references :bugzilla, null: false

      t.integer :bugid, null: false
      t.datetime :creation_ts, null: false
      t.text :short_desc, null: false
      t.datetime :delta_ts, null: false
      t.boolean :reporter_accessible, null: false
      t.boolean :cclist_accessible, null: false
      t.integer :classificationid, null: false
      t.string :classification, null: false
      t.string :product, null: false
      t.string :component, null: false
      t.string :version, null: false
      t.string :rep_platform, null: false
      t.string :op_sys, null: false
      t.string :bug_status, null: false
      t.string :resolution, null: false
      t.string :bug_file_loc, null: true
      t.string :status_whiteboard, null: true
      t.string :keywords, null: false, array: true
      t.string :priority, null: false
      t.string :bug_severity, null: false
      t.string :target_milestone, null: false
      t.integer :dependson, null: false, array: true
      t.boolean :everconfirmed, null: false
      t.string :reporter, null: false
      t.string :reporter_name, null: false
      t.string :assigned_to, null: false
      t.string :assigned_to_name, null: false
      t.string :cc, null: false, array: true
      t.integer :votes, null: false
      t.string :comment_sort_order, null: false

      t.timestamps null: false
    end

    add_index :org_eclipse_bugs_bugs, :bugzilla_id

    add_index :org_eclipse_bugs_bugs, :bugid
    add_index :org_eclipse_bugs_bugs, :creation_ts
    add_index :org_eclipse_bugs_bugs, :delta_ts
    add_index :org_eclipse_bugs_bugs, :classificationid
    add_index :org_eclipse_bugs_bugs, :classification
    add_index :org_eclipse_bugs_bugs, :product
    add_index :org_eclipse_bugs_bugs, :component
    add_index :org_eclipse_bugs_bugs, :version
    add_index :org_eclipse_bugs_bugs, :rep_platform
    add_index :org_eclipse_bugs_bugs, :op_sys
    add_index :org_eclipse_bugs_bugs, :bug_status
    add_index :org_eclipse_bugs_bugs, :resolution
    add_index :org_eclipse_bugs_bugs, :priority
    add_index :org_eclipse_bugs_bugs, :bug_severity
    add_index :org_eclipse_bugs_bugs, :target_milestone
    add_index :org_eclipse_bugs_bugs, :everconfirmed
    add_index :org_eclipse_bugs_bugs, :reporter
    add_index :org_eclipse_bugs_bugs, :reporter_name
    add_index :org_eclipse_bugs_bugs, :assigned_to
    add_index :org_eclipse_bugs_bugs, :assigned_to_name
    add_index :org_eclipse_bugs_bugs, :votes
  end
end
