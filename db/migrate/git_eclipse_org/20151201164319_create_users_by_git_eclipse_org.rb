class CreateUsersByGitEclipseOrg < ActiveRecord::Migration[5.0]
  def change
    create_table :git_eclipse_org_users do |t|
      t.integer :accountid, null: false
      t.string :username, null: true
      t.string :name, null: true
      t.string :email, null: true

      t.timestamps null: false
    end

    add_index :git_eclipse_org_users, :accountid, unique: true, name: 'index_git_eclipse_org_users_as_unique'
    add_index :git_eclipse_org_users, :username
    add_index :git_eclipse_org_users, :name
    add_index :git_eclipse_org_users, :email
  end
end
