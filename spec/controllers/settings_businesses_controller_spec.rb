require 'spec_helper'

describe Settings::BusinessesController do
  describe '#edit' do
    it 'should be successful' do
      get(:edit).should be_successful
    end

    it 'should get a business' do
      get :edit
      assigns(:business).should_not be_nil
    end
  end
end