describe Telegraph::NodeElement do
  let(:wrong_tag) { 'sidebar' }
  let(:valid_tag) { 'aside' }

  let(:valid_attr) { {'href' => 'http://test_href.com'} }
  let(:wrong_attr) { {'data' => 'wrong_data'} }

  let(:children) do
    ["Hello, world!"]
  end

  context 'wrong tag' do
    subject do
      described_class.new(wrong_tag, valid_attr, children)
    end

    it 'raises error' do
      expect{subject}.to raise_error ArgumentError, "Wrong tag: 'sidebar'. Check available tags."
    end
  end

  context 'valid tag' do
    subject { described_class.new(valid_tag, valid_attr, children) }

    its(:tag) { is_expected.to eq 'aside' }
    its(:attrs) { is_expected.to eq valid_attr }
  end

  context 'wrong attr' do
    subject { described_class.new(valid_tag, wrong_attr, children) }

    it 'raises error' do
      expect{subject}.to raise_error ArgumentError, "Wrong attribute: 'data'. Check available attributes."
    end
  end

  context 'valid attr' do
    subject { described_class.new(valid_tag, valid_attr, children) }

    its(:attrs) { is_expected.to eq valid_attr }
  end
end

