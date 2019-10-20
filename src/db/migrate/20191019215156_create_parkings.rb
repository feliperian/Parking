class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.string :plate
      t.timestamp :input
      t.datetime :output
      t.boolean :paid

      t.timestamps
    end
  end
end
