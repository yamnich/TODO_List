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

  it "routes '/projects/:project_id/members'   to 'project_memberships#index'" do
    { get:'/projects/1/members' }.should route_to(
      controller: 'project_memberships',
      action: 'index',
      project_id: '1'
      )
  end

  it "routes '/projects/:project_id/members/invite'   to 'project_memberships#new'" do
    { get:'/projects/1/members/invite' }.should route_to(
       controller: 'project_memberships',
       action: 'new',
       project_id: '1'
       )
  end

  it "routes post '/projects/:project_id/members/invite'   to 'project_memberships#create'" do
    { post:'/projects/1/members/invite' }.should route_to(
       controller: 'project_memberships',
       action: 'create',
       project_id: '1'
       )
  end

  it "routes '/projects/1/members/1'   to 'project_memberships#destroy'" do
    { delete:'/projects/1/members/1' }.should route_to(
      controller: 'project_memberships',
      action: 'destroy',
      project_id: '1',
      id: '1'
       )
  end

  it "routes '/signup'   to 'users#new'" do
    {get:'/signup' }.should route_to(
      controller: 'users',
       action: 'new',
        )
  end
  it "routes '/signin'   to 'sessions#new'" do
    { get:'/signin' }.should route_to(
        controller: 'sessions',
        action: 'new',
        )
  end

  it "routes '/signout'   to 'sessions#destroy'" do
    { get:'/signout' }.should route_to(
       controller: 'sessions',
       action: 'destroy',
       )
  end
  end