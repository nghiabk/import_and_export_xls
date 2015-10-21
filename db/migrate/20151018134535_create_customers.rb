class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :address
      t.string :tel
      t.string :email
      t.date :birth_day
      t.string :job

      t.timestamps null: false
    end
  end
end
