RSpec.shared_context "telegraph_shared_context", :shared_context => :metadata do
  let(:token) { ENV["TELEGRAPH_TOKEN"] }
  let(:client) { Telegraph.setup(token) }
end
