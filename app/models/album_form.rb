class AlbumForm
  include ActiveModel::Model

  attr_accessor :title, :description, :image, :user_id, :id, :created_at, :updated_at

  #バリデーション
  with_options presence: true do
    validates :title
    validates :description
    validates :image
    validates :user_id
  end

  def save
    Album.create(title: title, description: description, user_id: user_id, image: image)
  end

  def update(params, album)
    album.update(params)
  end

end