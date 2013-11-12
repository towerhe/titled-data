require 'spec_helper'

describe TitledData::Row do
  let(:values) {{ 'username' => 'user', 'email' => 'user@intimi.cn' }}
  let(:row) { TitledData::Row.new(values) }

  it 'returns the value of a specified title' do
    row.get(:username).should == 'user'
    row.get('username').should == 'user'
  end

  it 'sets the value of a specified title' do
    row.set_value(:username, 'another user')

    row.get(:username).should == 'another user'
  end

  it 'does nothing when the title is not valid' do
    row.set_value(:missing, 'missing')

    row.get(:missing).should_not be
  end

  it 'sets the values of valid titles' do
    row.set_values(username: 'another user', email: 'another_user@intimi.cn')

    row.get(:username).should == 'another user'
    row.get(:email).should == 'another_user@intimi.cn'
  end

  it 'returns a hash of all values' do
    row.get_values.should == values
    row.to_hash.should == values
  end
end
