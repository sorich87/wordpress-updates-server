require 'spec_helper'

describe Package do
  let(:package) { Fabricate.build(:package) }

  it { should validate_presence_of(:business) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:number_of_extensions) }
  it { should validate_presence_of(:number_of_domains) }
  it { should validate_presence_of(:validity) }
  it { should validate_presence_of(:extension_ids) }

  it { should validate_numericality_of(:number_of_domains) }
  it { should validate_numericality_of(:number_of_extensions) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:validity) }

  it { should be_embedded_in(:business) }
  it { should have_and_belong_to_many(:extensions) }

  it 'should be valid given valid attributes' do
    package.should be_valid
  end

  it 'is valid given all extensions' do
    package = Fabricate.build(:package, extensions: [], has_all_extensions: true)
    package.should be_valid
  end

  it 'is not valid with no extensions' do
    package = Fabricate.build(:package, extensions: [], has_all_extensions: false)
    package.should_not be_valid
  end

  describe '.price' do
    it 'returns the formatted price' do
      package.price.should == "%.2f" % package[:price]
    end
  end

  describe 'extension methods' do
    let(:plugin) { Fabricate(:plugin) }
    let(:theme) { Fabricate(:theme) }
    let(:package) { Fabricate.build(:package, extensions: [plugin, theme]) }

    describe '.plugins' do
      it 'returns the plugins' do
        package.plugins.all.entries.should == [plugin]
      end
    end

    describe '.themes' do
      it 'returns the themes' do
        package.themes.all.entries.should == [theme]
      end
    end
  end
end
