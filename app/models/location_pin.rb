class LocationPin < ActiveRecord::Base
  belongs_to :map
  belongs_to :trip
  has_many :photos
  has_many :posts

  validates :map, :presence => true
  validates :trip, :presence => true
  validates :longitude, numericality: true
  validates :latitude, numericality: true
end