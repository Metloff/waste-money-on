require '../lib/message_dispatcher'

class ResponseDispatcher
  attr_reader :response
  def initialize(response)
    @response = response
  end

  def run
    return if response.blank?
    return if !self.status
    return if !self.result
    
    result.each do |update|
      next if update['message'].blank?

      ::MessageDispatcher.new(update['message']).run
    end
  end

  protected

  def status
    return false if response['ok'].blank?
    response['ok']  
  end

  def result
    return [] if response['result'].blank?
    response['result']
  end
end
