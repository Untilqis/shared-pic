class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @album.comments.includes(:user)
  end

  def tag
    @user = current_user
    @tag = Tag.find_by(tag_name: params[:name])
    @albums = @tag.albums
  end

  def edit
    unless current_user.id == @album.user_id
      redirect_to action: :index
    end
  end

  def update
    if @album.update(album_params)
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

  def album_params
    params.require(:album).permit(:description, :tag_name, :image).merge(user_id: current_user.id)
  end

end
