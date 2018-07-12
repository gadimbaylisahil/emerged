class Creation < ApplicationRecord
  
  belongs_to :user
  belongs_to :category, optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :cover_photo

  acts_as_votable
  is_impressionable counter_cache: true, unique: true # Increments impressions_count field in db with unique ip address

  validates :content, presence: true
  validates :title,
            presence: true,
            length: { within: 4..50 }
  
  # Sort Scopes
  scope :most_liked,  ->           { order(cached_votes_up: :desc) }
  scope :most_viewed, ->           { order(impressions_count: :desc) }
  scope :recent, ->                { order(created_at: :desc)  }
  scope :most_shared, ->           { order(number_of_shares: :desc) }
  scope :most_discussed, ->        { order(cached_comments_count: :desc) }
  # Mapping allows us to convert the returned array of objects into ActiveRecord:Relation in order to not cause issues when
  # chaining other scopes afterwards
  scope :trending,    ->           { where(id: all.sort_by(&:trending_ratio).map(&:id).reverse)}
  
  # Filter Scopes
  scope :today,       ->           { where('creations.created_at >= ?', Date.today ) }
  scope :this_month,  ->           { where('creations.created_at >= ?', Date.current.at_beginning_of_month) }
  scope :this_year,   ->           { where('creations.created_at >= ?', Date.current.at_beginning_of_year) }
  scope :published,   ->           { where(published: true) }
  scope :subscribed,  -> (user_id) { where(category_id: User.find(user_id).following_by_type('Category').pluck(:id)) }
  scope :by_location, -> (country) { joins(:user).where("lower(users.country) = ?", country.downcase) }

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
