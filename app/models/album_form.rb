class AlbumForm
  include ActiveModel::Model

  attr_accessor(
    :title, :description, :image, :user_id,
    :id, :created_at, :updated_at,
    :tag_name
  )

  #バリデーション
  with_options presence: true do
    validates :title
    validates :description
    validates :image
    validates :user_id
  end

  def save
    album = Album.create(title: title, description: description, user_id: user_id, image: image)
    if tag_name.present?
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      AlbumTagRelation.create(album_id: album.id, tag_id: tag.id)
    end
  end

  def update(params, album)
    album.update(params)
  end

end