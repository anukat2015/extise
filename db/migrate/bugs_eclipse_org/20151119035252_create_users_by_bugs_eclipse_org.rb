class CreateUsersByBugsEclipseOrg < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_users do |t|
      t.string :login_name, null: false
      t.string :realnames, null: false, array: true

      t.timestamps null: false
    end

    add_index :bugs_eclipse_org_users, :login_name, unique: true, name: 'index_bugs_eclipse_org_users_as_unique'
  end
end
