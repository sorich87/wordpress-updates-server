require 'spec_helper'

describe Settings::BusinessesController do
  sign_in_user

  describe '#edit' do
    it 'should be successful' do
      get(:edit).should be_successful
    end
  end
end
