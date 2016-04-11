class CreateChangesByGitEclipseOrg < ActiveRecord::Migration
  def change
    create_table :git_eclipse_org_changes do |t|
      t.references :project, null: false
      t.references :owner, null: false

      t.integer :bugid, null: true
      t.integer :changeid, null: false
      t.string :project_name, null: false
      t.string :branch_name, null: false
      t.string :change_identifier, null: false
      t.text :subject, null: false
      t.string :status, null: false
      t.datetime :created, null: false
      t.datetime :updated, null: false

      t.timestamps null: false
    end

    add_index :git_eclipse_org_changes, :owner_id
    add_index :git_eclipse_org_changes, :project_id

    add_index :git_eclipse_org_changes, :bugid
    add_index :git_eclipse_org_changes, :changeid, unique: true, name: 'index_git_eclipse_org_changes_as_unique'
    add_index :git_eclipse_org_changes, :project_name
    add_index :git_eclipse_org_changes, :branch_name
    add_index :git_eclipse_org_changes, :change_identifier
    add_index :git_eclipse_org_changes, :status
    add_index :git_eclipse_org_changes, :created
    add_index :git_eclipse_org_changes, :updated
  end
end
