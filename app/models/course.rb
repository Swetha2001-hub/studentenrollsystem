class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments

  validates :name, presence: true
  validates :description, presence: true
  validates :duration, presence: true
  validates :instructor, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
