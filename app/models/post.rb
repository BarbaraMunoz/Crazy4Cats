class Post < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_by_title_and_username,
                  against: [:title],
                  associated_against: {
                    user: [:username]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  acts_as_votable
  has_many :likes

end
