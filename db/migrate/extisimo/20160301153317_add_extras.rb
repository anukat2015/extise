class AddExtras < ActiveRecord::Migration
  def change
    add_column :extisimo_repositories, :git_eclipse_org_parent, :string, null: false

    add_index :extisimo_repositories, :git_eclipse_org_parent
  end
end
