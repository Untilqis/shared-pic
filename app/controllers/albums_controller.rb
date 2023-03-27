class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    #@albums = Album.all
  end

  #def new
    #@album = Album.new
  #end

  #def create
    #@album = Album.new(prototype_params)
    #if @album.save
      #redirect_to root_path
    #else
      #render :new
    #end
  #end

  #def show
    #@album = Album.find(params[:id])
    #@comment = Comment.new
    #@comments = @album.comments.includes(:user)
  #end

  #def edit
    #@album = Album.find(params[:id])
    #unless current_user.id == @prototype.user_id
      #redirect_to action: :index
    #end
  #end

  #def update
    #@album = Album.find(params[:id])
    #if @album.update(album_params)
      #redirect_to prototype_path
    #else
      #render :edit
    #end
  #end

  #def destroy
    #album = Album.find(params[:id])
    #album.destroy
    #redirect_to root_path
  #end

  #private

  #def album_params
    #params.require(:album).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  #end

end
