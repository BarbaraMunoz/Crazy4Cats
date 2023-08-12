class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

        enum :role, [:normal, :ejecutivo, :admin]

        has_many :posts
        has_many :comments
        acts_as_voter
        validates :display_name, presence: true, if: -> { !username.present? && !user_signed_in? }
end
