class CreateConceptualities < ActiveRecord::Migration
  def change
    create_table :extisimo_conceptualities do |t|
      t.references :inferencer, null: false
      t.references :subject, null: false, polymorphic: true
      t.references :concept, null: false

      t.json :inferencer_data, null: false

      t.decimal :probability, null: false, precision: 9, scale: 8

      t.timestamps null: false
    end

    add_index :extisimo_conceptualities, [:concept_id, :subject_id, :subject_type, :inferencer_id], unique: true, name: 'index_extisimo_conceptualities_as_unique'

    add_index :extisimo_conceptualities, :inferencer_id
    add_index :extisimo_conceptualities, :subject_type
    add_index :extisimo_conceptualities, :subject_id
    add_index :extisimo_conceptualities, :concept_id

    add_index :probability
  end
end
