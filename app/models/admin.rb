class Admin < User
  has_many :stories
  has_many :creations
end