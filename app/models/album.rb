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

  #def exif_data
    #if image.attached? && image.blob.variable?
      #exif_data = Exiftool.new(image.blob.service.send(:path_for, image.blob.key)).to_hash
      #return exif_data
    #end
  #end

  #ローカル環境のみ動作するexiftool
  #<p class="information__title">情報</p>
  #<li><strong>撮影日:</strong> <%= l(DateTime.strptime(@album.exif_data[:date_time_original], '%Y:%m:%d %H:%M:%S'), format: :custom) %></li>
  #<li><strong>カメラ情報:</strong> <%= @album.exif_data[:model] %></li>
  #<li><strong>絞り値:</strong> <%= @album.exif_data[:aperture] %></li>
  #<li><strong>シャッタースピード:</strong> <%= @album.exif_data[:shutter_speed] %></li>
  #<li><strong>ISO感度:</strong> <%= @album.exif_data[:iso] %></li>
  
end
