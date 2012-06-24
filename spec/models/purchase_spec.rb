require 'spec_helper'

describe Purchase do
  it { should be_embedded_in(:customer) }
  it { should have_one(:package) }
  it { should have_many(:extensions) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:package_id) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:extension_ids) }
end
