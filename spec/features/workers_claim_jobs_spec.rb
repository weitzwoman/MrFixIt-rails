require 'rails_helper'

describe "how worker claims a job" do
  it "claims job", js: true do
    worker = create(:worker)
    job = create(:job)
    login_as(worker)
    visit jobs_path(job)
    click_link "Kitchen Sink"
    click_link "Click Here to Claim It Now"
    expect(page).to have_content("You claimed the job")
  end

end
