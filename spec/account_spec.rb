require 'telegraph'
require_relative 'telegraph_shared_context.rb'

describe Telegraph::Account do
  include_context "telegraph_shared_context"

  before(:each) do
    allow_any_instance_of(described_class).to receive(:client) { client }
  end

  subject { described_class.new(account_params) }

  its(:access_token) { is_expected.to eq token }
  its(:short_name) { is_expected.to eq 'test_name' }
  its(:author_name) { is_expected.to eq 'test_author' }
  its(:author_url) { is_expected.to eq 'http://test-url.com/' }
  its(:page_count) { is_expected.to eq 100 }
end