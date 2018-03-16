class Categorization < ApplicationRecord
  belongs_to :category, dependent: :nullify
  belongs_to :creation, dependent: :nullify
end
