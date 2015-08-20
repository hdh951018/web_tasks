class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :email
      t.string :name
      t.text :content
      t.boolean :is_checked

      t.timestamps null: false
    end
  end
end
