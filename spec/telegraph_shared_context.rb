RSpec.shared_context "telegraph_shared_context", :shared_context => :metadata do
  let(:token) { ENV["TELEGRAPH_TOKEN"] }
  let(:client) { Telegraph.setup(token) }
  let(:account_params) do
    {
      'short_name' => 'test_name',
      'author_name' => 'test_author',
      'author_url' => 'http://test-url.com/',
      'page_count' => 100
    }
  end
end