describe Telegraph::Page do
  let(:content) { [{"tag":"p","children":["Hello, world!"]}] }
  let(:page_params) do
    {
      'path' => 'Sample-Page-12-15',
      'url' => "http:\/\/telegra.ph\/Sample-Page-12-15",
      'title' => 'Sample Page',
      'description' => 'Hello, world!',
      'author_name' => 'Anonymous',
      'content' => content,
      'views' => 569
    }
  end

  subject { described_class.new(page_params) }

  its(:path) { is_expected.to eq 'Sample-Page-12-15' }
  its(:url) { is_expected.to eq "http:\/\/telegra.ph\/Sample-Page-12-15" }
  its(:title) { is_expected.to eq 'Sample Page' }
  its(:description) { is_expected.to eq 'Hello, world!' }
  its(:author_name) { is_expected.to eq 'Anonymous' }
  its(:content) { is_expected.to eq content }
  its(:views) { is_expected.to eq 569 }
end