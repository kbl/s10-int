require 'maildo'

module Maildo::Config
  Mail.defaults do
    retriever_method :pop3, 
                     :address    => 'pop.gmail.com',
                     :port       => 995,
                     :user_name  => 'rmutodo',
                     :password   => ENV['RMU_TODO_PASS'],
                     :enable_ssl => true
  end
end
