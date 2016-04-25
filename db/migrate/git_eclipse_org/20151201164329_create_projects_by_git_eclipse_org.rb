class CreateProjectsByGitEclipseOrg < ActiveRecord::Migration[5.0]
  def change
    create_table :git_eclipse_org_projects do |t|
      t.string :parent, null: false
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :git_eclipse_org_projects, :parent
    add_index :git_eclipse_org_projects, :name, unique: true, name: 'index_git_eclipse_org_projects_as_unique'
  end
end
