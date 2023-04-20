class Album < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :album_tag_relations
  has_many :tags, through: :album_tag_relations
  
  def exif_data
    if image.attached? && image.blob.variable?
      exif_data = Exiftool.new(image.blob.service.send(:path_for, image.blob.key)).to_hash
      
      return exif_data
    end
  end
  
end
