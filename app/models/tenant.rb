class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }

  has_many :leases
  has_many :apartments, through: :leases


end
