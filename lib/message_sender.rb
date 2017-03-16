class MessageSender
  attr_reader :user, :options
  def initialize(user, options)
    @user = user
    @options = options
  end
  
  def send
    uri = URI("https://api.telegram.org/bot#{token}/sendMessage")
    res = Net::HTTP.post_form(
              uri, 
              'chat_id' => user.telegram_id,
              'text'    => options[:text],
            )
  end

  def token
    YAML::load(IO.read('../config/secrets.yml'))['telegram_bot_token']
  end
end
