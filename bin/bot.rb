require 'net/http'
require 'json'
require '../lib/response_dispatcher'
require '../lib/extensions.rb'
require '../config/initialize/app_configurator.rb'


config = AppConfigurator.new
config.configure

token = config.get_token
logger = config.get_logger
logger.debug 'Starting telegram bot'

uri = URI("https://api.telegram.org/bot#{token}/getUpdates")

offset = 0

loop do
  res = Net::HTTP.post_form(uri, 'offset' => offset, 'timeout' => '40')
  res = JSON.parse(res.body)

  logger.debug "Response#{res}" 
  ResponseDispatcher.new(res).run

  offset = res['result'].last["update_id"] + 1 if !res['result'].empty?
end


## TODO

#1 Разобраться с регулярками и научиться парсить сообщения типа:
# - 100 еда
# -100 еда
# -10 кофе и рестораны
# - 10 кофе 2 шоп
# + 123 зарплата

#2 Разобраться с базами даннных

#3 Придумать что еще будет делать бот и как он будет выводить статистику
#4 Подумать над схемой БД (стоит ли создавать отдельную таблицу под категории и хранить там категории каждого юзера 
# и деньги потраченные на нее или же писать это в юзера.)


