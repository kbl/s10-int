require 'maildo'

module Maildo
  class Config

    attr_reader :sender, :store_path, :logdev

    def self.instance(&block)
      @@instance ||= Config.new(&block)
    end

    def initialize(&block)
      set_default_values
      instance_eval &block if block_given?
      initialize_mail
    end

    private

    def set_default_values
      @sender = 'rmutodo@gmail.com'
      @password = ENV['MAILDO_PASS']
      @logdev = STDOUT

      @store_path = '/tmp/todos'
    end

    def initialize_mail
      Mail.defaults do
        retriever_method :imap,
                       { address: 'imap.gmail.com',
                         port: 993,
                         user_name: @sender,
                         password: @password,
                         enable_ssl: true }
        delivery_method :smtp,
                      { address: 'smtp.gmail.com',
                        port: 587,
                        domain: 'rmu-maildo.com',
                        user_name: @sender,
                        password: @password,
                        authentication: 'plain',
                        enable_starttls_auto: true }
      end
    end

  end
end
