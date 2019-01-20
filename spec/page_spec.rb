require 'telegraph_rb'
require_relative 'telegraph_shared_context.rb'

describe Telegraph::Page, :vcr do
  include_context "telegraph_shared_context"

  let(:content) { [{"tag":"p","children":["Hello, world!"]}] }
  let(:page_params) do
    {
      path: 'Sample-Page-12-15',
      url: "http:\/\/telegra.ph\/Sample-Page-12-15",
      title: 'Sample Page',
      description: 'Hello, world!',
      author_name: 'Anonymous',
      content: content,
      views: 569
    }
  end

  subject { described_class.new(page_params) }

  its(:path) { is_expected.to eq 'Sample-Page-12-15' }
  its(:url) { is_expected.to eq "http:\/\/telegra.ph\/Sample-Page-12-15" }
  its(:title) { is_expected.to eq 'Sample Page' }
  its(:description) { is_expected.to eq 'Hello, world!' }
  its(:author_name) { is_expected.to eq 'Anonymous' }
  its(:content) { is_expected.to all be_a Telegraph::NodeElement }
  its(:views) { is_expected.to eq 569 }

  before { Telegraph.setup(token) }

  describe '.create' do
    it 'creates new page' do
      page = described_class.create(
        title: 'Sample Page',
        author_name: 'Anonymous',
        author_url: 'http://author.com',
        content: content,
        return_content: false
      )

      expect(page.title).to eq 'Sample Page'
      expect(page.author_name).to eq 'Anonymous'
      expect(page.content).to eq nil
    end
  end

  describe '.get' do
    subject { described_class.get(path: "test-title-02-21-4") }

    it { is_expected.to be_a Telegraph::Page }
    its(:url) { is_expected.to eq 'https://telegra.ph/test-title-02-21-4'}
    its(:title) { is_expected.to eq 'test title'}
    its(:description) { is_expected.to eq 'Hello, world!'}
    its(:views) { is_expected.to eq 0}
    its(:author_name) { is_expected.to eq 'test_author'}
    its(:author_url) { is_expected.to eq 'http://testauthorlink.com/'}
  end

  describe '.get_views' do
    it 'returns views number' do
      expect(
        described_class.get_views(path: "test-title-02-21-4")
      ).to eq 0
    end
  end

  describe '.edit' do
    subject do
      described_class.edit(path: page_params[:path], title: 'New Title', content: content)
    end

    its(:title) { is_expected.to eq "New Title"}
  end
end
