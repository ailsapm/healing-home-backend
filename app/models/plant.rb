class Plant < ApplicationRecord
  #associations
  has_and_belongs_to_many :recipes

  #validations
  validates :scientific_name, :common_name, presence: true, uniqueness: true
  validates :description, presence: true

  #search method for a-z by common/scientific name - case insensitive
  def self.search(query)
    where("common_name ILIKE ? OR scientific_name ILIKE ?", "%#{query}%", "%#{query}%")
  end
end