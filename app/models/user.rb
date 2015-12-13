class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_tagger
  
  attr_accessor :current_password
  has_many :favourites
  has_many :links
  has_many :learn_times

  def links_till( date)
    links.where("created_at >= ?", date).group('date(created_at)').count
  end

  def favourite_links
    self.links.where(favourite: true)
  end

  def user_learned_links
    learn_times.order(created_at: :desc).map { |learn_time| learn_time.link }.uniq
  end

  def user_learn_count_till(date)
    learn_times.where("created_at >= ?", date).group('date(created_at)').count
  end
end
