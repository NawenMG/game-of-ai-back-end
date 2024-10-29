# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  def initialize
    @repository = CommentRepository.new
    @service = CommentService.new(@repository)
  end

  # POST /comments
  def create
    comment_params = params.require(:comment).permit(:simulation_id, :user_id, :comment, :explanation, :timestamp)
    saved_comment = @service.create_comment(comment_params)

    # Invia un messaggio a Kafka per la creazione del commento
    success_message = "Comment created: #{saved_comment.to_json}"
    $kafka.deliver_message(success_message, topic: 'comments_actions')

    render json: { message: 'Comment created successfully' }, status: :created
  end

  # PUT /comments/:id
  def update
    comment_params = params.require(:comment).permit(:id, :simulation_id, :user_id, :comment, :explanation, :timestamp)
    updated_comment = @service.update_comment(comment_params)

    # Invia un messaggio a Kafka per l'aggiornamento del commento
    success_message = "Comment updated: #{updated_comment.to_json}"
    $kafka.deliver_message(success_message, topic: 'comments_actions')

    render json: { message: 'Comment updated successfully' }
  end

  # DELETE /comments/:id
  def destroy
    @service.delete_comment(params[:id])

    # Invia un messaggio a Kafka per l'eliminazione del commento
    success_message = "Comment deleted with ID: #{params[:id]}"
    $kafka.deliver_message(success_message, topic: 'comments_actions')

    render json: { message: 'Comment deleted successfully' }
  end

  # GET /comments/order
  def order
    direction = params[:direction] || 'asc'
    comments = @service.order_comments_by_timestamp(direction)
    render json: comments
  end
end
