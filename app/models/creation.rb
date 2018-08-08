class Creation < ApplicationRecord
  
  belongs_to :user
  belongs_to :category, inverse_of: :creations
  belongs_to :license
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :cover_photo

  acts_as_votable
  is_impressionable counter_cache: true, unique: true # Increments impressions_count field in db with unique ip address

  validates :content, presence: true
  validates :title,
            presence: true,
            length: { within: 4..50 }
  
  # Sort Scopes
  scope :most_liked,  ->           { order("creations.cached_votes_up DESC, creations.created_at DESC") }
  scope :most_viewed, ->           { order("creations.impressions_count DESC, creations.impressions_count DESC") }
  scope :recent, ->                { order("creations.created_at DESC")  }
  scope :most_shared, ->           { order("creations.number_of_shares DESC, creations.number_of_shares DESC") }
  scope :most_discussed, ->        { order("creations.cached_comments_count DESC, creations.cached_comments_count DESC") }
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
  scope :subscribed,  -> (user_id) { where(category_id: User.find(user_id).following_by_type('Category').pluck(:id)) }
  scope :by_location, -> (country) { joins(:user).where("lower(users.country) = ?", country.downcase) }
  # Search scope TODO: Implement simple search scope as filter for now. Use Solr later
  scope :search,      ->(query)    { where('lower(creations.title) LIKE ? or lower(creations.description) LIKE ?',
                                           "%#{query.downcase}%", "%#{query.downcase}%")}

  def self.followed_by(user)
    following_ids = user.all_following.pluck(:id)
    where(user_id: following_ids)
  end
  
  def trending_ratio
    TrendRatioCalculator.new(likes: cached_votes_up,
                             shares: number_of_shares,
                             views: impressions_count,
                             comments: cached_comments_count,
                             time: created_at).run
  end
end
