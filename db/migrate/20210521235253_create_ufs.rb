class CreateUfs < ActiveRecord::Migration[5.2]
  def change
    create_table :ufs do |t|
      t.integer :value
      t.date :date

      t.timestamps
    end
  end
end
