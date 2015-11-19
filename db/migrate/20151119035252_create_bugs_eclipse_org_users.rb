class CreateBugsEclipseOrgUsers < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_users do |t|
      t.string :login_name, null: false
      t.string :realname, null: false

      t.timestamps null: false
    end

    add_index :bugs_eclipse_org_users, :login_name, unique: true
    add_index :bugs_eclipse_org_users, :realname
  end
end
