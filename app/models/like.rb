class Like < ApplicationRecord
  belongs_to :creation, touch: true
  belongs_to :user
end
