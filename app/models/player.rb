class Player < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :male, :name_family, :name_given, :student_number

  has_and_belongs_to_many :teams
end
