require 'spec_helper'

describe "routing to matches" do

  it "routes / to pages#home" do
    { get: '/' }.should route_to(
      controller: 'pages',
      action: 'home'
    )
  end

  it "routes '/lists/:list_id/tasks/:state'  to 'tasks#members'" do
    { get: '/lists/1/tasks/done' }.should route_to(
      controller: 'tasks',
      action: 'members',
      list_id: "1",
      state: 'done'     )
  end

  it "routes '/signup'   to 'users#invite'" do
    {get:'/signup' }.should route_to(
      controller: 'users',
       action: 'new',
        )
  end
  it "routes '/signin'   to 'sessions#invite'" do
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