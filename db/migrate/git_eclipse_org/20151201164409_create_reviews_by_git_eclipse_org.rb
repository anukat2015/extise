class CreateReviewsByGitEclipseOrg < ActiveRecord::Migration
  def change
    create_table :git_eclipse_org_reviews do |t|
      t.references :change, null: false
      t.references :reviewer, null: false

      t.timestamps null: false
    end

    add_index :git_eclipse_org_reviews, [:change_id, :reviewer_id], unique: true, name: 'index_git_eclipse_org_reviews_as_unique'

    add_index :git_eclipse_org_reviews, :change_id
    add_index :git_eclipse_org_reviews, :reviewer_id
  end
end
