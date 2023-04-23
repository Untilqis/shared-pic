class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  def index
    @albums = Album.all
  end

  def new
    @album_form = AlbumForm.new
  end

  def create
    @album_form = AlbumForm.new(album_form_params)
    if @album_form.valid?
      @album_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @album.comments.includes(:user)
  end

  def edit
    album_attributes = @album.attributes
    @album_form = AlbumForm.new(album_attributes)
    unless current_user.id == @album.user_id
      redirect_to action: :index
    end
  end

  def update
    @album_form = AlbumForm.new(album_form_params)
    @album_form.tag_name = @album.tags.first&.tag_name
    # 画像を選択し直していない場合は、既存の画像をセットする
    @album_form.image ||= @album.image.blob
    if @album_form.valid?
      @album_form.update(album_form_params, @album)
      redirect_to album_path
    else
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to root_path
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_form_params
    params.require(:album_form).permit(:title, :description, :tag_name, :image).merge(user_id: current_user.id)
  end

end
