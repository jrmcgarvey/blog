class Order < ApplicationRecord
  validates :product_name, presence: true
  validates :product_count, presence: true
  validates :customer_id, presence: true
  belongs_to :customer
  validates_presence_of :customer
end
