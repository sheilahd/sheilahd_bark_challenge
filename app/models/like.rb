class Like < ApplicationRecord
  validates :user_id, uniqueness: {scope: :dog_id}
  belongs_to :user
  belongs_to :dog
end
