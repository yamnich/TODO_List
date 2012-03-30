require 'spec_helper'
require 'cancan'
require 'cancan/matchers'

describe "User" do
  before(:each) do
    @owner =  Factory.create(:user, name: "Owner", email: "owner@ua.fm")
    @invited_user = Factory.create(:user, name: "Invited", email: "invited@ua.fm")
    @user =   Factory.create(:user, name: "user", email: "user@ua.fm")
    @owner_ability = Ability.new(@owner)
    @invited_user_ability = Ability.new(@invited_user)
    @user_ability= Ability.new(@user)

    @project = Project.create!(name: "Project", user_id: @owner.id)
    @project.project_memberships.create(member_id: @invited_user.id )
  end

  describe "abilities" do

    describe "with Project" do
      it "let owner to manage" do
         @owner_ability.should be_able_to(:manage, @project)
      end

      it "let invited user" do
        [:read,:update, :members].each do |ability|
          @invited_user_ability.should be_able_to(ability, @project)
        end
      end

      it "don't let invited user" do
        [:manage, :destroy].each do |ability|
          @invited_user_ability.should_not be_able_to(ability, @project)
        end
      end

      it "don't let user " do
        [:manage, :destroy, :read, :update, :members].each do |ability|
          @user_ability.should_not be_able_to(ability, @project)
        end
      end

  end

    describe "with List" do
      before(:each) do
       @list = List.create!(name: "List", user_id: @owner.id, project_id: @project.id)
      end

      it "let owner " do
        @owner_ability.should be_able_to(:manage, @list)
      end

      it "let invited user " do
        @invited_user_ability.should be_able_to(:manage, @list)
      end

      it "don't let user " do
        [:manage, :destroy, :read, :update, :members].each do |ability|
          @user_ability.should_not be_able_to(ability, @project)
        end
      end

    end

    describe "with task" do
      before(:each) do
        @list = List.create!(name: "List", user_id: @owner.id, project_id: @project.id)
        @task = Task.create!(name: "Task", user_id: @owner.id, executor_id: @invited_user.id)
      end

      it "let owner" do
        @owner_ability.should be_able_to(:manage, @task)
      end

      it "let invited user " do
        @invited_user_ability.should be_able_to(:manage, @task)
      end

      it "don't let user to manage" do
        [:manage, :destroy, :read, :update, :members].each do |ability|
          @user_ability.should_not be_able_to(ability, @project)
        end
      end
    end

    describe "invite user to project" do
      before(:each) do
        @projectmembership = ProjectMembership.create!(member_id: @owner.id, project_id: @project.id)
      end

      it "let owner" do
        @owner_ability.should be_able_to(:manage, @projectmembership)
      end

      it "let invited user" do
        @invited_user_ability.should_not be_able_to(:manage, @projectmembership)
      end

      it "don't let user" do
        @user_ability.should_not be_able_to(:manage, @projectmembership)
      end
    end
  end

end
