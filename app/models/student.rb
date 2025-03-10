class Student < ApplicationRecord
    has_secure_password 
    has_many :enrollments
    has_many :courses, through: :enrollments
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  end
  
