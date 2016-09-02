class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :first_name
      t.string :email
      t.decimal :amount
      t.string :currency
      t.string :description

      t.timestamps null: false
    end
  end
end
