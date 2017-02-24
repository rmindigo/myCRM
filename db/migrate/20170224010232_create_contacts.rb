class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first
      t.string :last

      t.timestamps
    end
  end
end
