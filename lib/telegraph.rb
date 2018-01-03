require 'faraday'
require 'nokogiri'
require 'json'
require 'singleton'
require_relative 'telegraph/node_helper'
require_relative 'telegraph/connection'
require_relative 'telegraph/node_element'
require_relative 'telegraph/client'
require_relative 'telegraph/page_list'
require_relative 'telegraph/page_views'
require_relative 'telegraph/account'
require_relative 'telegraph/page'
require_relative 'telegraph/configuration'

module Telegraph
  def self.setup(token)
    configuration.key = token
    @client = Client.new(configuration.key)
  end

  def self.create_account(attrs = {})
    client.create_account(attrs)
  end

  private

  def self.configuration
    Configuration.instance
  end

  def self.client
    @client ||= Client.new(configuration.key)
  end
end