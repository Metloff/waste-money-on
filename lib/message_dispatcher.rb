require '../models/transaction'
require '../models/user'


class MessageDispatcher
  attr_reader :message
  def initialize(message)
    @message = message
    @changeMessage = Struct.new(:sign, :amount, :title, :category)    
  end

  def run
    return if message.blank?
    return if !self.text
    return if self.user.blank?

    self.respond
    # case self.text
    # when 'Cтатистика'          then self.show_statistic
    # when 'Месяц'               then self.month
    # when 'Сезон'               then self.seson
    # when 'Год'                 then self.year
    # else self.parse
    # end
      
    # puts self.text
  end
  
  protected

  def respond
    on /^\/start/ do
      self.entry_explanation  ## TODO: Вводное сообщение объясняющее работу бота
    end

    on /^Статистика/ do
      self.show_statistic     ## TODO: Выводит доп кнопки для показа статистики за Месяц/Сезон/Год
    end
    
    on /^Месяц/ do
      self.month         ## TODO: Выводит стастистику за Месяц
    end
    
    on /^Сезон/ do
      self.seson         ## TODO: Выводит стастистику за Сезон
    end

    on /^Год/ do
      self.year          ## TODO: Выводит стастистику за Год
    end

    on /(\d{0,})(.*)#(.*)?/ do
      self.parse(arr)
    end  
  end

  def on regexp, &block
    m = self.text.match(regexp)
    return if m.blank?  ## TODO: Вернуть юзеру ошибку
                        ## TODO: Сделать Пул Реквест создателям образца

    yield m
  end
  
  def parse(arr)
    return if arr.blank?
    return if arr.length > 1


    puts arr.inspect
  end

  def reg_exp
    # @reg_exp ||=  /(-|\+)(\s?)(\d{0,})(\s?)([a-zA-Z--.,]*\s?)+/
      @reg_exp ||=  /(-|\+)\s?(\d{0,})(.*)#(.*)?/
  end
  
  
  def text
    return @text if defined?(@text)
    return false if message['text'].blank?
    
    @text = message['text']
  end

  def from
    @from ||= @message['from']
  end

  def user
    return @user if defined?(@user)
    return if from.blank?
    return if from['id'].blank?

    @user = User.find_or_create_user(from)
  end
  
end