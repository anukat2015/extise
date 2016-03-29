class CreateLabelsByGitEclipseOrg < ActiveRecord::Migration
  def change
    create_table :git_eclipse_org_labels do |t|
      t.references :change, null: false

      t.string :key, null: false
      t.string :value, null: false

      t.string :names, null: false, array: true

      t.timestamps null: false
    end

    add_index :git_eclipse_org_labels, [:change_id, :key], unique: true, name: 'index_git_eclipse_org_labels_as_unique'

    add_index :git_eclipse_org_labels, :change_id

    add_index :git_eclipse_org_labels, :key
  end
end
