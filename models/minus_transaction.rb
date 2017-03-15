require 'active_record'

class MinusTransaction < ActiveRecord::Base

  # #############################################################
  # Associations

  belongs_to :user

  # #############################################################
  # Validations

  validates :amount,    presence: true, numericality: { greater_than: 0 }
  validates :title,     length: { :maximum => 250 }
  validates :category,  presence: true, length: { :maximum => 250 }
end