require 'spec_helper'

describe Customer do
  let(:customer) { Fabricate.build(:customer) }

  it 'is valid given valid attributes' do
    customer.should be_valid
  end

  it { should validate_presence_of(:email) }
  it {
    Fabricate(:business)
    should validate_uniqueness_of(:email)
  }
  it { should_not allow_value("notatallcorrect").for(:email) }
  it { should_not allow_value("without@tld").for(:email) }
  it { should_not allow_value("without@.domain").for(:email) }

  it { should have_and_belong_to_many(:businesses) }
  it { should embed_many(:purchases) }
  it { should embed_many(:sites) }
end
