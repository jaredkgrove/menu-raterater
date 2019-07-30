class Restaurant < ActiveRecord::Base
  # include Slugifiable::InstanceMethods
  # extend Slugifiable::ClassMethods
  has_many :menu_items
  has_many :ratings, through: :menu_items
end
