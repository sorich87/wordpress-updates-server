require 'spec_helper'

describe Package do
  let(:package) { Fabricate.build(:package) }

  it 'should be valid given valid attributes' do
    package.should be_valid
  end

  it { should validate_presence_of(:business) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:number_of_extensions) }
  it { should validate_presence_of(:number_of_domains) }
  it { should validate_presence_of(:billing) }
  it { should validate_presence_of(:validity) }

  it { should validate_numericality_of(:number_of_domains) }
  it { should validate_numericality_of(:number_of_extensions) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:validity) }

  [-1, 999, :one_time_payment, "one time payment"].each do |v|
    it { should_not allow_value(v).for(:billing) }
  end

  it { should be_embedded_in(:business) }
  it { should have_and_belong_to_many(:extensions) }
end
