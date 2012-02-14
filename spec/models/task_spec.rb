require "rspec"

describe Task do

  it {should belong_to :list}
 # it {should belong_to :executor}

  it "should create list with valid attributes" do
    lambda{
      Factory.create(:task)
    }.should change{Task.count}.by(1)
  end
end