require 'telegraph_rb'
require_relative 'telegraph_shared_context.rb'

require 'byebug'

describe Telegraph::PageList, :vcr do
  include_context "telegraph_shared_context"

  before { Telegraph.setup(token) }

  describe '.get' do
    subject { described_class.get }

    its(:pages) { is_expected.to all be_a(Telegraph::Page) }
    its(:total_count) { is_expected.to eq 610 }
  end
end
