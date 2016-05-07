class CreateExpertises < ActiveRecord::Migration[5.0]
  def change
    create_table :extisimo_expertises do |t|
      t.references :metric, null: false
      t.references :subject, null: false, polymorphic: true
      t.references :user, null: false

      t.json :metric_data, null: false

      t.decimal :value, null: false, precision: 24, scale: 12

      t.timestamps null: false
    end

    add_index :extisimo_expertises, [:user_id, :subject_id, :subject_type, :metric_id], unique: true, name: 'index_extisimo_expertises_as_unique'

    add_index :extisimo_expertises, :subject_type

    add_index :extisimo_expertises, :value
  end
end
