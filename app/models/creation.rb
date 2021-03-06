class Creation < ApplicationRecord
  
  belongs_to :user
  belongs_to :category, inverse_of: :creations
  belongs_to :license
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :cover_photo

  is_impressionable counter_cache: true, unique: true # Increments impressions_count field in db with unique ip address

  validates :content, presence: true
  validates :title,
            presence: true,
            length: { within: 4..50 }
  
  # Mapping allows us to convert the returned array of objects into ActiveRecord:Relation in order to not cause issues when
  # chaining other scopes afterwards
  # TODO: fix trending sort
  scope :trending,    ->           { where(id: all.sort_by(&:trending_ratio).map(&:id))}
  
  # Filter Scopes
  scope :featured,    ->           { where(featured: true) }
  scope :today,       ->           { where('creations.created_at >= ?', Date.today ) }
  scope :this_month,  ->           { where('creations.created_at >= ?', Date.current.at_beginning_of_month) }
  scope :this_year,   ->           { where('creations.created_at >= ?', Date.current.at_beginning_of_year) }
  scope :published,   ->           { where(published: true) }
  scope :subscribed,  -> (user_id) { where(category_id: User.find_by(id: user_id).follows_by_type('Category').pluck(:followable_id)) }
  scope :by_location, -> (country) { joins(:user).where("lower(users.country) = ?", country.first.downcase) }
  # Search scope TODO: Implement simple search scope as filter for now. Use Solr later
  scope :search,      ->(query)    { where('lower(creations.title) LIKE ? or lower(creations.description) LIKE ?',
                                           "%#{query.first.downcase}%", "%#{query.first.downcase}%")}

  def self.followed_by(user)
    following_ids = user.all_following.pluck(:id)
    where(user_id: following_ids)
  end
  
  def liked_by(user)
    return if liked_by?(user)
    likes.create!(user: user)
  end
  
  def unliked_by(user)
    return unless liked_by?(user)
    likes.find_by(user: user)&.destroy!
    true
  end

  def liked_by?(user)
    likes.find_by(user: user).present?
  end
  
  def like_count
    likes.count
  end
  
  def trending_ratio
    TrendRatioCalculator.new(shares: shares_count,
                             views: impressions_count,
                             time: created_at).run
  end
end
