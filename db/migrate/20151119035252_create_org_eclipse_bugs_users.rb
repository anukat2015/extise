class CreateOrgEclipseBugsUsers < ActiveRecord::Migration
  def change
    create_table :org_eclipse_bugs_users do |t|
      t.string :login_name, null: false
      t.string :realname, null: false

      t.timestamps null: false
    end

    add_index :org_eclipse_bugs_users, :login_name, unique: true
    add_index :org_eclipse_bugs_users, :realname, unique: true
  end
end
