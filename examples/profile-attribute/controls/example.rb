val_user = attribute('user', value: 'alice', description: 'An identification for the user')
val_password = attribute('password', description: 'A value for the password')

describe val_user do
  it { should eq 'bob' }
end

describe val_password do
  it { should eq 'secret' }
end
