class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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
    @album = Album.find(params[:id])
    @comment = Comment.new
    @comments = @album.comments.includes(:user)
  end

  def edit
    @album = Album.find(params[:id])
    album_attributes = @album.attributes
    @album_form = AlbumForm.new(album_attributes)
    unless current_user.id == @album.user_id
      redirect_to action: :index
    end
  end

  def update
    @album = Album.find(params[:id])
    @album_form = AlbumForm.new(album_form_params)
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
    album = Album.find(params[:id])
    album.destroy
    redirect_to root_path
  end

  private

  def album_form_params
    params.require(:album_form).permit(:title, :description, :tag_name, :image).merge(user_id: current_user.id)
  end

end
