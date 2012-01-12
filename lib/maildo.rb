module Maildo

  require 'logger'
  require 'pstore'
  require 'mail'

  require 'maildo/config'
  require 'maildo/mail_server'
  require 'maildo/dispatcher'

  require 'maildo/list/store'
  require 'maildo/list/subscribers'
  require 'maildo/list/tasks'

  require 'maildo/message/response'
  require 'maildo/message/no_op'
  require 'maildo/message/sender_aware_message'
  require 'maildo/message/subscribers_aware_message'
  require 'maildo/message/subscribe'
  require 'maildo/message/unsubscribe'
  require 'maildo/message/tasks_aware_message'
  require 'maildo/message/add'
  require 'maildo/message/done'
  require 'maildo/message/list'

  require 'maildo/message/parser'

end
