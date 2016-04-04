class CreateChangesByGitEclipseOrg < ActiveRecord::Migration
  def change
    create_table :git_eclipse_org_changes do |t|
      t.references :project, null: false
      t.references :owner, null: false

      t.integer :bugid, null: false
      t.integer :changeid, null: false
      t.string :status, null: false
      t.string :commit_identifier, null: false, limit: 40
      t.string :change_identifier, null: false, limit: 40
      t.integer :history_size, null: false

      t.timestamps null: false
    end

    add_index :git_eclipse_org_changes, :owner_id
    add_index :git_eclipse_org_changes, :project_id

    add_index :git_eclipse_org_changes, :bugid, unique: true
    add_index :git_eclipse_org_changes, :changeid, unique: true, name: 'index_git_eclipse_org_changes_as_unique'
    add_index :git_eclipse_org_changes, :status
    add_index :git_eclipse_org_changes, :commit_identifier
    add_index :git_eclipse_org_changes, :change_identifier
    add_index :git_eclipse_org_changes, :history_size
  end
end
