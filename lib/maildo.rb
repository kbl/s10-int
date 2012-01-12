require 'logger'
require 'pstore'
require 'mail'

require_relative 'maildo/config'
require_relative 'maildo/mail_server'
require_relative 'maildo/dispatcher'

require_relative 'maildo/list/store'
require_relative 'maildo/list/subscribers'
require_relative 'maildo/list/tasks'

require_relative 'maildo/message/response'
require_relative 'maildo/message/no_op'
require_relative 'maildo/message/sender_aware_message'
require_relative 'maildo/message/subscribers_aware_message'
require_relative 'maildo/message/subscribe'
require_relative 'maildo/message/unsubscribe'
require_relative 'maildo/message/tasks_aware_message'
require_relative 'maildo/message/add'
require_relative 'maildo/message/done'
require_relative 'maildo/message/list'

require_relative 'maildo/message/parser'
