require 'spec_helper'

describe Business do
  let(:business) { Fabricate.build(:business) }

  it 'is valid given valid attributes' do
    business.should be_valid
  end

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(50) }

  it { should validate_presence_of(:email) }
  it {
    Fabricate(:business)
    should validate_uniqueness_of(:email)
  }
  it { should_not allow_value("notatallcorrect").for(:email) }
  it { should_not allow_value("without@tld").for(:email) }
  it { should_not allow_value("without@.domain").for(:email) }

  it { should embed_many(:packages) }
  it { should have_and_belong_to_many(:customers) }
  it { should have_many(:users) }
  it { should have_many(:extensions) }

  describe 'extension methods' do
    let(:business) { Fabricate.build(:business) }
    let(:plugin) { Fabricate(:plugin, business: business) }
    let(:theme) { Fabricate(:theme, business: business) }

    describe '.plugins' do
      it 'returns the plugins' do
        business.plugins.should == [plugin]
      end
    end

    describe '.themes' do
      it 'returns the themes' do
        business.themes.should == [theme]
      end
    end
  end
end
