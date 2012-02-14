require "rspec"

describe ProjectMembership do

  it {should belong_to :project}
  it {should belong_to :member}

end