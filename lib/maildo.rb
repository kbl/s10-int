module Maildo

  require 'mail'
  require 'maildo/config'
  require 'maildo/mail_server'
  require 'maildo/dispatcher'

  require 'maildo/message/base'
  require 'maildo/message/subscribe'
  require 'maildo/message/unsubscribe'
  require 'maildo/message/add'
  require 'maildo/message/done'
  require 'maildo/message/list'

  require 'maildo/message/parser'

end
