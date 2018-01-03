require 'telegraph'

describe Telegraph, :vcr do
  let(:token) { ENV["TELEGRAPH_TOKEN"] }

  describe 'self.create_account' do
    context 'short_name given' do
      subject do
        Telegraph.create_account(
          short_name: 'test_name',
          author_name: 'test_author',
          author_url: 'http://author.com'
        )
      end

      it { is_expected.to be_a Telegraph::Account }
      its("short_name") { is_expected.to eq('test_name')}
      its("author_name") { is_expected.to eq('test_author')}
      its("author_url") { is_expected.to eq('http://author.com/')}
    end

    context 'short_name not given' do
      subject do
        -> { Telegraph.create_account(
          short_name: '',
          author_name: 'test_author',
          author_url: 'http://author.com'
        ) }
      end

      it { is_expected.to raise_error(ArgumentError, "SHORT_NAME_REQUIRED") }
    end
  end

  describe 'self.client' do
    subject { Telegraph.setup(token) }

    it 'creates telegraph client' do
      expect(subject).to be_a Telegraph::Client
    end
    its("token") { is_expected.to eq(token)}
  end
end