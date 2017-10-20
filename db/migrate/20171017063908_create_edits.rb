class CreateEdits < ActiveRecord::Migration[5.0]
  def change
    create_table :edits do |t|
      t.integer :document_id
      t.integer :user_id
      t.integer :del_start, default: -1
      t.integer :del_end, default: -1
      t.integer :addition, default: -1
      t.string :addition_text, default: ""

      t.timestamps
    end
  end
end
