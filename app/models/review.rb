class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu_item
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
  validates_presence_of :unique_user_menu_item_relation?

  def unique_user_menu_item_relation?
    if self.menu_item.reviews.detect{|review|review.user == self.user}
    else
      true
    end
  end
end
 
