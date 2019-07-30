class MenuItem < ActiveRecord::Base
  belongs_to :restaurant
  validates_uniqueness_of :name, scope: :restaurant
end
