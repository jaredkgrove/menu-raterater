class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :ratings, through: :menu_items
end
