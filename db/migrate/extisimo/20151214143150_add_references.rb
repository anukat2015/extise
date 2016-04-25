class AddReferences < ActiveRecord::Migration[5.0]
  def add_reference(table, reference, options = {})
    if options.delete :multiple
      references = "#{table}_#{reference.to_s.pluralize}"

      create_table references, id: false do |t|
        t.references table.to_s.singularize, options
        t.references reference, options
      end

      add_index references, %W(#{table.to_s.singularize}_id #{reference}_id), unique: true, name: "index_#{references}_as_unique"
      add_index references, "#{reference}_id", unique: true, name: "index_#{references}_as_guard"
    else
      add_column table, "#{reference}_id", :integer, options
      add_index table, "#{reference}_id", unique: true
    end
  end

  def change
    # NOTE: each user always references one or many bugs.eclipse.org users, and none or many git.eclipse.org users

    add_reference :extisimo_users, :bugs_eclipse_org_user, null: false, multiple: true
    add_reference :extisimo_users, :git_eclipse_org_user, null: false, multiple: true

    # NOTE: each user caches all eclipse.org user names to speed things up a little bit

    add_column :extisimo_users, :eclipse_org_user_names, :string, null: false, array: true
    add_index :extisimo_users, :eclipse_org_user_names

    # NOTE: each task always references single bugs.eclipse.org bug, and none or many git.eclipse.org changes,
    # however since a bug can point to multiple changes and a change to multiple bugs both associations are
    # marked as multiple hence enabling future implementations to create tasks merged from multiple bugs also

    add_reference :extisimo_tasks, :bugs_eclipse_org_bug, null: false, multiple: true
    add_reference :extisimo_tasks, :git_eclipse_org_change, null: false, multiple: true

    # NOTE: each post, attachment, interaction and repository references one original eclipse.org entity

    add_reference :extisimo_posts, :bugs_eclipse_org_comment, null: false
    add_reference :extisimo_attachments, :bugs_eclipse_org_attachment, null: false
    add_reference :extisimo_interactions, :bugs_eclipse_org_interaction, null: false

    add_reference :extisimo_repositories, :git_eclipse_org_project, null: true

    # NOTE: each repository references project's parent since it is missing in bugs.eclipse.org original data

    add_column :extisimo_repositories, :git_eclipse_org_project_parent, :string, null: false
    add_index :extisimo_repositories, :git_eclipse_org_project_parent
  end
end
