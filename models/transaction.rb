require 'active_record'

class Transaction < ActiveRecord::Base
  belongs_to :user
end