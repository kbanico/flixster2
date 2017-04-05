class Course < ApplicationRecord
  belongs_to :user
  has_many :sections
  validates :title, presence: true, length: {minimum:3, maximum:100}
  validates :description, presence: true, length: {minimum:3, maximum:100}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
end
