# app/repositories/comment_repository_mongo.rb
class CommentRepositoryImpl
  include CommentRepository

  def initialize
    @collection = Mongoid::Clients.default[:comments]
  end

  # Trova tutti i commenti
  def find_all
    @collection.find.to_a
  end

  # Trova un commento per ID
  def find_by_id(id)
    @collection.find(_id: id).first
  end

  # Salva un nuovo commento
  def save(comment)
    @collection.insert_one(comment)
  end

  # Aggiorna un commento esistente
  def update(comment)
    @collection.find(_id: comment[:id]).update_one('$set' => comment)
  end

  # Elimina un commento
  def delete(id)
    @collection.find(_id: id).delete_one
  end

  # Ordina i commenti per timestamp
  def order_by_timestamp(direction = 'asc')
    sort_order = direction == 'asc' ? 1 : -1
    @collection.find.sort(timestamp: sort_order).to_a
  end
end

