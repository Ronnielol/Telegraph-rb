require 'faraday'
require 'faraday_middleware'
require 'dry-struct'
require 'json'
require_relative 'telegraph_rb/types'
require_relative 'telegraph_rb/connection'
require_relative 'telegraph_rb/client'
require_relative 'telegraph_rb/node_element'
require_relative 'telegraph_rb/page'
require_relative 'telegraph_rb/page_list'
require_relative 'telegraph_rb/account'
require_relative 'telegraph_rb/html_converter'

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
