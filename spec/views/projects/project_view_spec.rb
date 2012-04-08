require 'spec_helper'

describe "projects/index.html.haml"  do
  before(:each) do
    @user = Factory.create(:user)
    sign_in @user

    @project = mock_model(Project, id: 1, name: "Project", save: true)

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
  end

  #it "should display 'New project'" do
   # rendered.should have_selector("New project")
  #end
end
