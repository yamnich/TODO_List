require "rspec"

describe ProjectMembership do

  it {should belong_to :project}
  it {should belong_to :member}
  subject { ProjectMembership.create! }
  it { should validate_uniqueness_of(:member_id).scoped_to(:project_id)}

end