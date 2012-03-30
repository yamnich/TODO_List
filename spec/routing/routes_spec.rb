require 'spec_helper'

describe "routing to matches" do

  it "routes / to pages#home" do
    { get: '/' }.should route_to(
      controller: 'pages',
      action: 'home'
    )
  end

  it "routes '/lists/:list_id/tasks/:state'  to 'tasks#index'" do
    { get: '/lists/1/tasks/done' }.should route_to(
      controller: 'tasks',
      action: 'index',
      list_id: "1",
      state: 'done'     )
  end
=begin
  it "routes delete '/projects/:id/members/:member_id' to 'projects#remove_member'"  do
    { delete: '/projects/1/members/1'}.should route_to(
        controller: 'projects',
        action: 'remove_member',
        id: "1",
        member_id: "1"  )
  end
end
=end
end