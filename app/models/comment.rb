class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true  # Permitir que el usuario sea opcional (para comentarios de "invitado")
  attribute :display_name, :string

  validates :content, presence: true
end
