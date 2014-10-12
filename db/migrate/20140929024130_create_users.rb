class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phonenumber
      t.integer :level
      t.string :address
      t.string :password
      t.timestamps
    end
  end
end
