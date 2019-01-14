require 'faraday'
require 'faraday_middleware'
require 'dry-struct'
require 'json'
require_relative 'telegraph/types'
require_relative 'telegraph/connection'
require_relative 'telegraph/client'
require_relative 'telegraph/account'
require_relative 'telegraph/page'
require_relative 'telegraph/html_converter'

module Telegraph
  class << self
    attr_accessor :client

    def setup(token)
      @client = Client.new(token)
    end

    def create_account(short_name:, author_name:, author_url:)
      account = Account.create(
        short_name: short_name,
        author_name: author_name,
        author_url: author_url
      )
      @client = Client.new(account.access_token)
      account
    end
  end
end
