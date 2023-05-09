class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.text       :description, null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
