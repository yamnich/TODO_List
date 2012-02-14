require "spec_helper"

describe Project do

  it {should have_many(:lists).dependent(:destroy)}
  it {should belong_to :user}
  it {should have_many :project_memberships}
  it {should have_many(:members).through(:project_memberships)}
  it {should validate_presence_of :name}

  it "should create project with valid attributes" do
    lambda{
      Factory.create(:project)
    }.should change{Project.count}.by(1)
  end
end