class CreateRecipees < ActiveRecord::Migration[7.0]
  def change
    create_table :recipees do |t|
      t.string :name
      t.float :preparation_time
      t.float :cooking_time
      t.text :description
      t.boolean :public

      t.timestamps
    end
  end
end
