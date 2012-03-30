require "rspec"

describe Task do

  it {should belong_to :list}
  it {should belong_to :executor}
  it {should belong_to :user}

  it "should create list with valid attributes" do
    lambda{
      Factory.create(:task)
    }.should change{Task.count}.by(1)
  end

  it "should accept valid states" do
    ["done", "in_work"].each do |state|
      should allow_value(state).for(:state)
    end
  end

  it "should change task state form 'done' to 'in_work'" do
    @task = Factory.create(:task, state: 'in_work')
    ['done','in_work'].each do |state|
      @task.change_state
      @task.state.should == state
    end
  end


end