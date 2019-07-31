class MenuItem < ActiveRecord::Base
  belongs_to :restaurant
  has_many :reviews
  validates_uniqueness_of :name, scope: :restaurant
end
 