class CreateAlbumTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :album_tag_relations do |t|
      t.references :album, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
