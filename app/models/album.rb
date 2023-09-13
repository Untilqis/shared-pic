class Album < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :album_tag_relations, dependent: :destroy
  has_many :tags, through: :album_tag_relations

  #バリデーション
  with_options presence: true do
    validates :description
    validates :image
    validates :user_id
  end
  
  after_create do
    album = Album.find_by(id: self.id)
    tags  = self.description.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    album.tags = []
    tags.uniq.map do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Tag.find_or_create_by(tag_name: tag.downcase.delete('#'))
      album.tags << tag
    end
  end

  before_update do 
    album = Album.find_by(id: self.id)
    album.tags.clear
    tags = self.description.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(tag_name: tag.downcase.delete('#'))
      album.tags << tag
    end
  end

  def exif_data
    if image.attached? && image.blob.variable?
      puts "Attempting to retrieve Exif data..."
      exif_data = Exiftool.new(image.blob.service.send(:path_for, image.blob.key)).to_hash
      Rails.logger.debug("Exif Data: #{exif_data.inspect}")
      return exif_data
    end
  end

end
