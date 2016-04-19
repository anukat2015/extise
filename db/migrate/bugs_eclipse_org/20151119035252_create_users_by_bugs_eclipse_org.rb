class CreateUsersByBugsEclipseOrg < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_users do |t|
      t.string :login_name, null: false
      t.string :realname, null: true

      t.timestamps null: false
    end

    # NOTE: provided login names in original data from bugs.eclipse.org still pose significant ambiguity and
    # no other user identifier is provided hence user uniqueness is determined by both login and real names

    add_index :bugs_eclipse_org_users, [:login_name, :realname], unique: true, name: 'index_bugs_eclipse_org_users_as_unique'

    add_index :bugs_eclipse_org_users, :login_name
    add_index :bugs_eclipse_org_users, :realname
  end
end
