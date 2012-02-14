require "spec_helper"

describe List do

  it {should have_many(:tasks).dependent(:destroy)}
  it {should belong_to :user}
  it {should belong_to :project}

  it {should validate_presence_of :name}

  it "should create list with valid attributes" do
    lambda{
      Factory.create(:list)
    }.should change{List.count}.by(1)
  end
end