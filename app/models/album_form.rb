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
    #一度タグの紐付けを消す
    album.album_tag_relations.destroy_all
    #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)
    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?
    #タグを保存
    tag.save if tag_name.present?
    album.update(params)
    AlbumTagRelation.create(album_id: album.id, tag_id: tag.id) if tag_name.present?
  end

end