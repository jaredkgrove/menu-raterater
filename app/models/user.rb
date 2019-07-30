class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_secure_password
  has_many :reviews
  has_many :menu_items, through: :reviews
  has_many :restaurants, through: :menu_items
  validates_presence_of :username, :password
end
