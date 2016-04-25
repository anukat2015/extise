class CreateLabelsByGitEclipseOrg < ActiveRecord::Migration[5.0]
  def change
    create_table :git_eclipse_org_labels do |t|
      t.references :change, null: false
      t.references :user, null: false

      t.string :name, null: false
      t.integer :value, null: true
      t.boolean :approved, null: false
      t.string :date, null: true

      t.timestamps null: false
    end

    add_index :git_eclipse_org_labels, [:change_id, :user_id, :name], unique: true, name: 'index_git_eclipse_org_labels_as_unique'

    add_index :git_eclipse_org_labels, :change_id
    add_index :git_eclipse_org_labels, :user_id

    add_index :git_eclipse_org_labels, :name
    add_index :git_eclipse_org_labels, :value
    add_index :git_eclipse_org_labels, :approved
    add_index :git_eclipse_org_labels, :date
  end
end
