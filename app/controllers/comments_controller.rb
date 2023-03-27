class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to album_path(@comment.album)
    else
      @album = @comment.album
      @comments = @album.comments
      render "albums/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, album_id: params[:album_id])
  end
end
