require 'spec_helper'

describe "projects/index.html.haml"  do
  before(:each) do
    @user = Factory.create(:user)
    sign_in @user

    @project = mock_model(Project, id: 1, name: "Project", save: true)
    @projects = [@project, @project]
    @projects_invited_in = [@project, @project]
    @project.stub!(:description)

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }

    render

  end

  it "should display 'New project'" do
    rendered.should have_selector("a", content: "New project")
  end

  it "should have 'Edit' link" do
    rendered.should have_selector("a", content: "Edit project")
  end
end
