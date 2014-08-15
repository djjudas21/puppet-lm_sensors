require 'spec_helper'
describe 'lm_sensors' do

  context 'with defaults for all parameters' do
    it { should contain_class('lm_sensors') }
  end
end
