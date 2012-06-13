require 'spec_helper'

describe Version do
  let(:version) { build(:version) }

  it { should validate_presence_of(:version) }
end
