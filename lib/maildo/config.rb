require 'maildo'

module Maildo::Config
  Mail.defaults do
    retriever_method :imap, 
                   { address: 'imap.gmail.com',
                     port: 993,
                     user_name: 'rmutodo',
                     password: ENV['MAILDO_PASS'],
                     enable_ssl: true }
    delivery_method :smtp, 
                  { address: 'smtp.gmail.com',
                    port: 587,
                    domain: 'rmu-maildo.com',
                    user_name: 'rmutodo@gmail.com',
                    password: ENV['MAILDO_PASS'],
                    authentication: 'plain',
                    enable_starttls_auto: true } 
  end
end
