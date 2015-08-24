class AddDescriptionToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :description, :string
  end
end
