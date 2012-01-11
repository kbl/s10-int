require 'maildo'

module Maildo
  module Config

    TODO_LISTS_PATH = '/tmp/todos'
    PROBE_INTERVAL = 10
    SENDER = 'rmutodo@gmail.com'

    Mail.defaults do
      retriever_method :imap,
                     { address: 'imap.gmail.com',
                       port: 993,
                       user_name: SENDER,
                       password: ENV['MAILDO_PASS'],
                       enable_ssl: true }
      delivery_method :smtp,
                    { address: 'smtp.gmail.com',
                      port: 587,
                      domain: 'rmu-maildo.com',
                      user_name: SENDER,
                      password: ENV['MAILDO_PASS'],
                      authentication: 'plain',
                      enable_starttls_auto: true }
    end

  end
end
