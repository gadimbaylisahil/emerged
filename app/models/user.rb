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
  after_create :create_profile
  accepts_nested_attributes_for :profile

  acts_as_tagger
  private
  def create_profile
    self.create_profile!
  end
end
