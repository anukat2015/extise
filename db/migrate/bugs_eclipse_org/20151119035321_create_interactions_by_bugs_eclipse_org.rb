class CreateInteractionsByBugsEclipseOrg < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs_eclipse_org_interactions do |t|
      t.references :attachment, null: false

      t.string :bug_url, null: false, limit: 2048
      t.integer :version, null: false
      t.string :kind, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :originid, null: false
      t.string :structure_kind, null: true
      t.string :structure_handle, null: true, limit: 1024
      t.string :navigation, null: true
      t.string :delta, null: true
      t.decimal :interest, null: false, precision: 20, scale: 12

      t.timestamps null: false
    end

    # NOTE: provided attributes of available Mylyn context data from bugs.eclipse.org still
    # pose significant ambiguity and hence its impossible to specify a unique index here

    add_index :bugs_eclipse_org_interactions, :bug_url
    add_index :bugs_eclipse_org_interactions, :version
    add_index :bugs_eclipse_org_interactions, :kind
    add_index :bugs_eclipse_org_interactions, :start_date
    add_index :bugs_eclipse_org_interactions, :end_date
    add_index :bugs_eclipse_org_interactions, :originid
    add_index :bugs_eclipse_org_interactions, :structure_kind
  end
end
