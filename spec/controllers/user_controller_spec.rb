require 'spec_helper'

describe UsersController do

  render_views

  before(:each) do
    @user = Factory(:user)
  end

  describe "GET 'new'" do

    it "it should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", content: 'Sign up')
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end

  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {name: "", email: "", password: "", password_confirmation: "1"}
      end

      it "should not create a user" do
        lambda do
            post :create, user: @attr
           end.should_not change(User, :count)

      end

      it "should render the 'new' page" do
        post :create, user: @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, user: @attr
        response.should have_selector("title", content: 'Sign up')
      end
    end

    describe "success" do
      before(:each) do
        @attr = {name: "New User", email: "newuser@email.com", password: "111111", password_confirmation: "111111"}
      end

      it "should create a user" do
        lambda do
          post :create, user: @attr
        end.should change(User, :count).by(1)
      end

      it "should sign the user in" do
        post :create, user: @attr
        controller.should be_signed_in
      end

      it "should redirect to root path" do
        post :create, user: @attr
        response.should redirect_to(root_path)
      end

      it "should have a welcome message" do
        post :create, user: @attr
        flash[:success].should == "Welcome!"
      end

    end

    describe "GET 'edit'" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end

      it "should change user's attributes" do
        put :edit, id: @user
       response.should be_success
      end

      it "should have the right title" do
        get :edit, id: @user
        response.should have_selector("title", content: "Edit User")
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @user=Factory(:user)
        test_sign_in(@user)
      end

      describe "failure" do
        before(:each) do
          @attr = {name: "", email: "", password: "", password_confirmation: "1" }
        end

        it "should render the 'edit' page" do
          put :update, id: @user, user: @attr
          response.should render_template('edit')
        end

        it "should have the right title" do
          put :update, id: @user, user: @attr
          response.should have_selector("title", content: "Edit user")
        end
      end

      describe "success" do
        before(:each) do
          @attr = {name: "New name", email: "newuser@email.com", password: "password", password_confirmation: "password"    }
        end

        it "should change the user's attributes'" do
          put :update, id: @user, user: @attr
          @user.reload
          @user.name.should == @attr[:name]
          @user.email.should == @attr[:email]
        end

        it "should redirect to the user show page" do
          put :update, id:  @user, user: @attr
          response.should redirect_to(root_path)
        end

        it "should have a flash message" do
          put :update, id:  @user, user: @attr
          flash[:success].should =~ /updated/
        end
      end
    end

    describe "authentication of edit/update" do

      before(:each) do
        @user = Factory(:user)
      end
=begin
      describe "for non-signed-in users" do

        it "should deny access to 'edit'" do
          get :edit, id: @user
          response.should redirect_to(signin_path)
        end

        it "should deny access to 'update'" do
          put :update, id: @user, user:  {}
          response.should redirect_to(signin_path)
        end

      end
=end
      describe "for signed-in users" do

        before(:each) do
          wrong_user = Factory(:user, :email => "user@example.net")
          test_sign_in(wrong_user)
        end

        it "should require matching users for 'edit'" do
          get :edit, id: @user
          response.should redirect_to(root_path)
        end

        it "should require matching users for 'update'"  do
          put :update, id: @user, user: {}
          response.should redirect_to(root_path)
        end
      end
    end



  end

end