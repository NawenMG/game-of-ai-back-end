# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
  def initialize
    @repository = CommentRepositoryMongo.new
    @service = CommentService.new(@repository)
  end

  # POST /comments
  def create
    comment_params = params.require(:comment).permit(:simulation_id, :user_id, :comment, :explanation, :timestamp)
    @service.create_comment(comment_params)
    render json: { message: 'Comment created successfully' }, status: :created
  end

  # PUT /comments/:id
  def update
    comment_params = params.require(:comment).permit(:id, :simulation_id, :user_id, :comment, :explanation, :timestamp)
    @service.update_comment(comment_params)
    render json: { message: 'Comment updated successfully' }
  end

  # DELETE /comments/:id
  def destroy
    @service.delete_comment(params[:id])
    render json: { message: 'Comment deleted successfully' }
  end

  # GET /comments/order
  def order
    direction = params[:direction] || 'asc'
    comments = @service.order_comments_by_timestamp(direction)
    render json: comments
  end
end
