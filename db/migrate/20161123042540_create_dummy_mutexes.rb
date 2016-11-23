class CreateDummyMutexes < ActiveRecord::Migration[5.0]
  def change
    create_table :dummy_mutexes do |t|
      t.integer :number

      t.timestamps
    end
  end
end
