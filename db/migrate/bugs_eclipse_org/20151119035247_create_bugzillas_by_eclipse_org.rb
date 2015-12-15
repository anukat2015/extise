class CreateBugzillasByEclipseOrg < ActiveRecord::Migration
  def change
    create_table :bugs_eclipse_org_bugzillas do |t|
      t.string :version, null: false
      t.string :urlbase, null: false, limit: 2048
      t.string :maintainer, null: false

      t.timestamps null: false
    end

    add_index :bugs_eclipse_org_bugzillas, :version
    add_index :bugs_eclipse_org_bugzillas, :urlbase, unique: true, name: 'index_bugs_eclipse_org_bugzillas_as_unique'
    add_index :bugs_eclipse_org_bugzillas, :maintainer
  end
end
