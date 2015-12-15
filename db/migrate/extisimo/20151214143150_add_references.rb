class AddReferences < ActiveRecord::Migration
  def add_reference(table, reference)
    add_column table, "#{reference}_id", :integer, null: false
    add_index table, "#{reference}_id", unique: true
  end

  def change
    add_reference :extisimo_users, :bugs_eclipse_org_user
    add_reference :extisimo_tasks, :bugs_eclipse_org_bug
    add_reference :extisimo_posts, :bugs_eclipse_org_comment
    add_reference :extisimo_attachments, :bugs_eclipse_org_attachment
    add_reference :extisimo_interactions, :bugs_eclipse_org_interaction
  end
end
