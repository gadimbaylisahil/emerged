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
  has_one :profile
  before_create :build_profile
  accepts_nested_attributes_for :profile

  private
  def build_profile
    self.build_profile
  end
end
