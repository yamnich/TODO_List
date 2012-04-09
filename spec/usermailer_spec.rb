describe "UserMailer" do

    before(:all) do
      @user = Factory.create(:user)
      @project = Factory.create(:project)

    end

    describe "invite" do
      before(:each) do
        @email = UserMailer.invite(@user, @project)
      end

    it "should be set to be delivered to the email passed in" do
        @email.should deliver_to(@user)
      end

      it "should have the correct subject" do
        @email.should have_subject("#{@user.name}, you were invited to the project #{@project}")
      end
    end

    describe "assigment" do
      before(:each) do
        @task = Factory.create(:task)
        @email = UserMailer.assignment(@user, @task)
      end

      it "should be set to be delivered to the email passed in" do
        @email.should deliver_to(@user)
      end

      it "should have the correct subject" do
        @email.should have_subject("You get invite to task #{@task}")
      end
    end


    describe "assigment" do
      before(:each) do
        @task = Factory.create(:task)
        @email = UserMailer.changed(@user,@project, @task)
      end

      it "should be set to be delivered to the email passed in" do
        @email.should deliver_to(@user)
      end

      it "should have the correct subject" do
        @email.should have_subject("Your task '#{@task}' state in '#{@project}' project was changed")
      end
    end

end