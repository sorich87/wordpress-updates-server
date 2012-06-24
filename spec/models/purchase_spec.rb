require 'spec_helper'

describe Purchase do
  let(:purchase) { Fabricate.build(:purchase) }

  it 'is valid given valid attributes' do
    purchase.should be_valid
  end

  it { should be_embedded_in(:customer) }
  it { should have_and_belong_to_many(:extensions) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:extension_ids) }
end
