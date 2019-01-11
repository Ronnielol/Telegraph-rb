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

  describe 'self.create' do
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

  # describe 'revoke_token' do
  #   subject { account.revoke_token }

  #   it { is_expected.to be_a Telegraph::Account }
  #   its(:access_token) { is_expected.to_not eq(account.access_token)  }
  # end

  describe 'get_account_info' do
    subject do
      described_class.get_account_info(access_token: account.access_token)
    end

    it { is_expected.to be_a Telegraph::Account }
    its(:short_name) { is_expected.to eq 'test_name' }
    its(:author_name) { is_expected.to eq 'test_author' }
    its(:author_url) { is_expected.to eq 'http://testauthorlink.com/' }
  end

  describe 'edit' do
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

  describe 'create_page' do
    let(:content) { [{"tag":"p","children":["Hello, world!"]}] }

    subject do
      account.create_page(
        title: "test title",
        author_name: account.author_name,
        author_url: account.author_url,
        content: content,
        return_content: false
      )
    end

    it { is_expected.to be_a Telegraph::Page}
    its(:path) { is_expected.to eq 'test-title-02-27-8'}
    its(:url) { is_expected.to eq 'http://telegra.ph/test-title-02-27-9'}
    its(:title) { is_expected.to eq 'test title'}
    its(:description) { is_expected.to eq ''}
    its(:views) { is_expected.to eq 0}
    its(:can_edit) { is_expected.to eq true}
    its(:author_name) { is_expected.to eq 'test_author'}
    its(:author_url) { is_expected.to eq 'http://testauthorlink.com/'}
    its(:content) { is_expected.to be nil}

    describe 'return_content: true' do
      subject do
        account.create_page(
          title: "test title",
          author_name: account.author_name,
          author_url: account.author_url,
          content: content,
          return_content: true
        )
      end

      its(:content) { is_expected.to match_array(content) }
    end
  end

  describe 'get_page' do
    subject { account.get_page(path: "test-title-02-21-4") }

    it { is_expected.to be_a Telegraph::Page }
    its(:url) { is_expected.to eq 'http://telegra.ph/test-title-02-21-4'}
    its(:title) { is_expected.to eq 'test title'}
    its(:description) { is_expected.to eq 'Hello, world!'}
    its(:views) { is_expected.to eq 0}
    its(:author_name) { is_expected.to eq 'test_author'}
    its(:author_url) { is_expected.to eq 'http://testauthorlink.com/'}
  end

  describe 'get_page_list' do
    subject { account.get_page_list }

    it { is_expected.to be_a Telegraph::PageList }
    its(:total_count) { is_expected.to eq 0}
  end

  describe 'get_views' do
    context 'without path' do
      subject { account.get_views(path: "test-title-02-21-323") }

      it 'raises ArgumentError' do
        expect{subject}.to raise_error ArgumentError, 'PAGE_NOT_FOUND'
      end
    end

    context 'with path' do
      subject { account.get_views(path: "test-title-02-27-4") }

      it {is_expected.to be_an Telegraph::PageViews}
      its(:views) {is_expected.to eq 0}
    end
  end
end