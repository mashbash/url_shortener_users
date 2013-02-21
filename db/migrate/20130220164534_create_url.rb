class CreateUrl < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long
      t.string :short
      t.integer :click_count, :default => 0
    end  
  end
end
