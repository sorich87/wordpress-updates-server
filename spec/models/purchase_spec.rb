require 'spec_helper'

describe Purchase do
  it { should belong_to(:customer) }
  it { should belong_to(:package) }
  it { should have_and_belong_to_many(:extensions) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:package_id) }
  it { should validate_presence_of(:purchase_date) }
  it { should validate_presence_of(:extension_ids) }
end
