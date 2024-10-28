# app/repositories/comment_repository.rb

module CommentRepository
  def find_all
    raise NotImplementedError
  end

  def find_by_id(id)
    raise NotImplementedError
  end

  def save(comment)
    raise NotImplementedError
  end

  def update(comment)
    raise NotImplementedError
  end

  def delete(id)
    raise NotImplementedError
  end

  def order_by_timestamp(direction = 'asc')
    raise NotImplementedError
  end
end
