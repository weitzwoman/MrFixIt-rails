require 'rails_helper'

describe User do
  it { should have_many(:workers).through(:jobs) }
end
