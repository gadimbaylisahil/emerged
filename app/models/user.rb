class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: {
      "artist" => "artist",
      "supporter" => "supporter",
      "admin" => "admin"
  }
  validates :role, presence: true
end
