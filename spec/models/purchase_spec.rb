require 'spec_helper'

describe Purchase do
  it { should belong_to(:customer) }
  it { should belong_to(:package) }
  it { should have_and_belong_to_many(:themes) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:package) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:themes) }
end
