require 'spec_helper'

describe Package do
  let(:package) { build(:package) }

  context "helpers" do
    it 'should respond to validity methods' do
      package.should respond_to(:is_valid_for_life?)
    end

    it 'should respond to payment methods' do
      package.should respond_to(:is_subscription?)
    end
  end

  context '#CREATE' do
    it 'should be valid given valid attributes' do
      package.should be_valid
    end

    it { should validate_presence_of(:business) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:number_of_themes) }
    it { should validate_presence_of(:number_of_domains) }
    it { should validate_presence_of(:billing) }
    it { should validate_presence_of(:validity) }

    it { should validate_numericality_of(:price) }

    it 'should reject invalid validity values' do
      [-1, 999, "invalid", :lifetime].each do |v|
        should_not allow_value(v).for(:validity)
      end
    end

    it 'should reject invalid billing values' do
      [-1, 999, :one_time_payment, "one time payment"].each do |v|
        should_not allow_value(v).for(:billing)
      end
    end
  end

  it { should belong_to(:business) }
  it { should have_many(:customers) }
  it { should have_and_belong_to_many(:themes) }
end
