require 'rails_helper'

describe Job do
  # it { should belong_to :worker }
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
