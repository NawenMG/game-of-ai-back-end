# app/services/comment_service.rb

class CommentService
  def initialize(repository)
    @repository = repository
  end

  def find_all_comments
    @repository.find_all
  end

  def find_comment_by_id(id)
    @repository.find_by_id(id)
  end

  def create_comment(comment_params)
    @repository.save(comment_params)
  end

  def update_comment(comment_params)
    @repository.update(comment_params)
  end

  def delete_comment(id)
    @repository.delete(id)
  end

  def order_comments_by_timestamp(direction = 'asc')
    @repository.order_by_timestamp(direction)
  end
end
