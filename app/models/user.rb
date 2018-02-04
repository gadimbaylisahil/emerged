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
  has_one :artist_profile
  has_one :supporter_profile
  before_create :build_profile
  accepts_nested_attributes_for :artist_profile
  accepts_nested_attributes_for :supporter_profile

  private
  def build_profile
    case self.role
      when 'artist'
        self.build_artist_profile
      when 'supporter'
        self.build_supporter_profile
    end
  end
end
