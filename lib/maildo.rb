module Maildo

  require 'mail'
  require 'maildo/config'
  require 'maildo/mail_server'
  require 'maildo/dispatcher'

  require 'maildo/list/file_content'
  require 'maildo/list/subscribers'
  require 'maildo/list/tasks'

  require 'maildo/message/sender_aware_message'
  require 'maildo/message/subscribe'
  require 'maildo/message/unsubscribe'
  require 'maildo/message/add'
  require 'maildo/message/done'
  require 'maildo/message/list'

  require 'maildo/message/parser'

end
