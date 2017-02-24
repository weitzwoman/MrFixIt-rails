require 'rails_helper'

describe Worker do
  it { should have_many(:users).through(:jobs) }
end
