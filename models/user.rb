require 'active_record'

class User < ActiveRecord::Base
  has_many :transactions

  ### Methods

  def self.find_or_create_user(from)
    @user = User.find_by(telegram_id: from['id']) || self.register_user(from)
  end

  def self.register_user(from)
    @user = User.new(telegram_id: from['id'])
    @user.update_attributes(first_name: from['first_name'], last_name: from['last_name'])
    @user
  end
  
end