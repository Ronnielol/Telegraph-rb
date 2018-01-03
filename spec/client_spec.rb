require_relative 'telegraph_shared_context.rb'

describe Telegraph::Client, :vcr do
  include_context "telegraph_shared_context"

  let(:configuration) {Telegraph.configuration}
  let(:test_account) {Telegraph::Account.new(account_params)}

  describe 'create_page' do
    subject { client.create_page({title: 'keka', content: content}) }

    context 'content given' do
      let(:content) { [{tag: 'p', children:['Hello']}].to_json }

      it 'creates page' do
        expect(subject).to be_a Telegraph::Page
      end

      its(:url) {is_expected.to eq('http://telegra.ph/keka-11-30-2')}
    end

    context 'content not given' do
      let(:content) { [{tag: 'p', children:['']}].to_json }

      it 'raises error' do
        expect{subject}.to raise_error(ArgumentError, 'CONTENT_TEXT_REQUIRED')
      end
    end
  end

  describe 'edit_account_info' do
    before(:each) do
      allow(client).to receive(:account) {test_account}
    end

    subject do
      client.edit_account_info(
          short_name: 'new name',
          author_name: 'new author',
          author_url: 'http://new-url.com'
      )
    end

    it { is_expected.to be_a Telegraph::Account }

    it 'changes account short_name' do
      expect{subject}.to change{client.account.short_name}.from('test_name').to('new name')
    end
    it 'changes account author_name' do
      expect{subject}.to change{client.account.author_name}.from('test_author').to('new author')
    end
    it 'changes account author_url' do
      expect{subject}.to change{client.account.author_url}.from('http://test-url.com/').to('http://new-url.com/')
    end
  end

  describe 'get_account_info' do
    context 'without arguments' do
      subject { client.get_account_info }

      it 'returns account with all available fields' do
        expect(subject.short_name).to eq('new name')
        expect(subject.author_name).to eq('new author')
        expect(subject.author_url).to eq('http://new-url.com/')
        expect(subject.page_count).to eq(101)
      end
    end

    context 'with arguments' do
      subject { client.get_account_info('short_name') }

      it 'returns account only with given fields' do
        expect(subject.short_name).to eq('new name')
        expect(subject.author_name).to be nil
      end
    end
  end

  describe 'get_page' do
    context 'return_content: true' do
      let(:content_array) { [{"tag"=>"p", "children"=>["Hello"]}] }

      subject do
        client.get_page(
          path: 'keka-11-30-2',
          return_content: true
        )
      end

      its(:path) {is_expected.to eq('keka-11-30-2')}
      its(:content) {is_expected.to eq content_array }
    end

    context 'return_content: false' do
      subject do
        client.get_page(
          path: 'keka-11-30-2',
          return_content: false
        )
      end

      it {is_expected.to be_a Telegraph::Page}
      its(:path) {is_expected.to eq('keka-11-30-2')}
      its(:content) {is_expected.to be nil}
    end
  end

  describe 'get_page_list' do

    context 'without limit' do
      subject { client.get_page_list(offset: 0, limit: 0) }

      it {is_expected.to be_a Telegraph::PageList}
      its(:total_count) {is_expected.to eq(120)}

      it 'returns all list with 50(default) pages' do
        expect(subject.pages.size).to eq(50)
      end
    end

    context 'with limit' do
      subject { client.get_page_list(offset: 0, limit: 10) }

      it 'returns all list with 10 pages' do
        expect(subject.pages.size).to eq(10)
      end
    end

    context 'withouth offset' do
      subject { client.get_page_list(offset: 0, limit: 0) }

      let(:first_page) { 'http://telegra.ph/Tysyachelikij-geroj-Part-11-12-05' }

      it "first page url must be first_page" do
        expect(subject.first.url).to eq(first_page)
      end
    end

    context 'with offset' do
      subject { client.get_page_list(offset: 1, limit: 0) }

      let(:second_page) { 'http://telegra.ph/Harry-Potter-and-the-Prisoner-of-Azkaban-Part-2126-12-05' }

      it "first page url must be second_page" do
        expect(subject.first.url).to eq(second_page)
      end
    end
  end

  describe 'get_views' do
    context 'with path' do
      subject { client.get_views(path: 'Tysyachelikij-geroj-Part-11-12-05') }

      it {is_expected.to be_a Telegraph::PageViews}
      its(:views) { is_expected.to eq(0) }
    end

    context 'withouth path' do
      subject { client.get_views() }

      it 'raises ArgumentError' do
        expect{subject}.to raise_error ArgumentError, 'PAGE_NOT_FOUND'
      end
    end

    context 'with month, but without year' do
      subject do
        client.get_views(
          path: 'Tysyachelikij-geroj-Part-11-12-05',
          month: 12
        )
      end

      it 'raises ArgumentError' do
        expect{subject}.to raise_error ArgumentError, 'YEAR_MISSING'
      end
    end

    context 'with month and year' do
      subject do
        client.get_views(
          path: 'Tysyachelikij-geroj-Part-11-12-05',
          month: 12,
          year: 2017
        )
      end

      its(:views) { is_expected.to eq(0) }
    end
  end

  # describe 'revoke_access_token' do
  #   before(:each) do
  #     allow(client).to receive(:token) {test_account}
  #   end
  # end
end