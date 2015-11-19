class CreateOrgEclipseBugsBugzillas < ActiveRecord::Migration
  def change
    create_table :org_eclipse_bugs_bugzillas do |t|
      t.string :version, null: false
      t.string :urlbase, null: false, limit: 2048
      t.string :maintainer, null: false

      t.timestamps null: false
    end

    add_index :org_eclipse_bugs_bugzillas, :version
    add_index :org_eclipse_bugs_bugzillas, :urlbase, unique: true
    add_index :org_eclipse_bugs_bugzillas, :maintainer
  end
end
