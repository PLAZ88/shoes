class Item < ActiveRecord::Base
  belongs_to :user
  has_many :purchases
  has_many :buyers, :through => :purchases  

  validates :product, presence: true, length: { minimum: 2 }
  validates :price, presence: true, :numericality => { :greater_than => 0 }
end
