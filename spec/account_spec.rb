require 'telegraph'
require_relative 'telegraph_shared_context.rb'

describe Telegraph::Account, :vcr do
  include_context "telegraph_shared_context"

  let(:account) do
    described_class.create(
      short_name: 'test_name',
      author_name: 'test_author',
      author_url: 'http://testauthorlink.com'
    )
  end

  before { Telegraph.setup(token) }

  describe '.create' do
    subject do
      described_class.create(
        short_name: 'test_name',
        author_name: 'test_author',
        author_url: 'http://testauthorlink.com'
      )
    end

    its(:short_name) { is_expected.to eq 'test_name' }
    its(:author_name) { is_expected.to eq 'test_author' }
    its(:author_url) { is_expected.to eq 'http://testauthorlink.com/' }
    its(:access_token) { is_expected.to be }
  end

  describe '#edit' do
    subject do
      account.edit(
        short_name: 'new_name',
        author_name: 'new_author',
        author_url: 'http://newlink.com'
      )
    end

    it { is_expected.to be_a Telegraph::Account }
    its (:short_name) { is_expected.to eq 'new_name' }
    its (:author_name) { is_expected.to eq 'new_author' }
    its (:author_url) { is_expected.to eq 'http://newlink.com/' }
  end

  describe '.get' do
    subject do
      described_class.get
    end

    it { is_expected.to be_a Telegraph::Account }
    its(:short_name) { is_expected.to eq 'new name' }
    its(:author_name) { is_expected.to eq 'new author' }
    its(:author_url) { is_expected.to eq 'http://new-url.com/' }
  end

  describe '#get_pages' do
    subject { account.get_pages }

    it { is_expected.to be_an Array }
    its(:size) { is_expected.to eq 0}
  end
end
