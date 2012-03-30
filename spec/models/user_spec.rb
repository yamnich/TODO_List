require 'spec_helper'

describe User do
  it {should have_many(:projects).through(:project_memberships)}
  it {should have_many(:project_memberships)}
  it {should have_many  :lists}
  it {should have_many :tasks}
  it {should validate_presence_of :name}
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}
  it {should ensure_length_of(:password).is_at_least(6).is_at_most(40)}
  it {should ensure_length_of(:name).is_at_most(50)}
end
