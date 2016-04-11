class AddReferences < ActiveRecord::Migration
  def add_reference(table, reference, options = {})
    add_column table, "#{reference}_id", :integer, options
    add_index table, "#{reference}_id", unique: true
  end

  def change
    add_reference :extisimo_users, :bugs_eclipse_org_user, null: false
    add_reference :extisimo_posts, :bugs_eclipse_org_comment, null: false
    add_reference :extisimo_attachments, :bugs_eclipse_org_attachment, null: false
    add_reference :extisimo_interactions, :bugs_eclipse_org_interaction, null: false

    add_reference :extisimo_users, :git_eclipse_org_user, null: true
    add_reference :extisimo_repositories, :git_eclipse_org_project, null: true

    # NOTE: each task always references a single bug, and none or many changes

    add_reference :extisimo_tasks, :bugs_eclipse_org_bug, null: false

    create_table :extisimo_tasks_git_eclipse_org_changes, id: false do |t|
      t.references :extisimo_task, null: false
      t.references :git_eclipse_org_change, null: false
    end

    add_index :extisimo_tasks_git_eclipse_org_changes, [:extisimo_task_id, :git_eclipse_org_change_id], unique: true, name: 'index_extisimo_tasks_git_eclipse_org_changes_as_unique'
    add_index :extisimo_tasks_git_eclipse_org_changes, :git_eclipse_org_change_id, unique: true, name: 'index_extisimo_tasks_git_eclipse_org_changes_as_guard'

    # NOTE: each repository references project's parent since it is missing in bugs.eclipse.org original data

    add_column :extisimo_repositories, :git_eclipse_org_project_parent, :string, null: false
    add_index :extisimo_repositories, :git_eclipse_org_project_parent
  end
end
