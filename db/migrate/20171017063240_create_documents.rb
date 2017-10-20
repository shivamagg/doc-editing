class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :text
      t.boolean :is_available, default: :true

      t.timestamps
    end
  end
end
