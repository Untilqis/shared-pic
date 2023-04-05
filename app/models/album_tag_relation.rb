class AlbumTagRelation < ApplicationRecord
  #アソシエーション
  belongs_to :album
  belongs_to :tag
end
