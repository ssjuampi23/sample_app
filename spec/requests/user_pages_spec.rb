require 'spec_helper'

describe "UserPages" do

  subject { page }
    
  describe "signup page" do
    before { visit signup_path } 
    it { should have_selector_h1("Sign up")}
    it { should have_selector_title("Sign up")}
  
  end
  
  describe "profile page" do
    let(:user){ FactoryGirl.create(:user) }#code to make a user variable
    before { visit user_path(user)}
    
    it { should have_selector_h1(user.name)}
    it { should have_selector_title(user.name)}
  end
  
  describe "signup" do
    before { visit signup_path } #this simulates the user clicking the link to the Sign Up page
    let(:submit){ "Create my account" }
    
    describe "with invalid information" do
     it "should not create a user" do
       expect { click_button submit }.not_to change(User,:count) #here we are making a call to the variable "submit" that was previously created
     end
    end
    
    #Exercise 2 from Chapter 7. Write tests for the error messages.
    describe "after submission" do
      before{ click_button submit }
    
      it { should have_selector_title("Sign up")}
      
      it{ should have_content_message('error')}
      
     it{ should have_content_message("Password can't be blank")}
     it{ should have_content_message("Name can't be blank")}
     it{ should have_content_message("Email can't be blank")}
     it{ should have_content_message("Email is invalid")}
     it{ should have_content_message("Password is too short (minimum is 6 characters)")}
     it{ should have_content_message("Password confirmation can't be blank")}
  
    end
    
    describe "with valid information" do
      #TEST
      before{ fill_user_information()}
    #before{ click_button "Sign in" }
      it "should create a user" do
        
        #expect{ click_button "Confirmation" }.to change(User,:count).by(1)
        expect{ click_button submit }.to change(User,:count).by(1)
      end
    
      describe "after saving the user" do
    
      before{ click_button submit}
      let(:user){ User.find_by_email('user@example.com') }

      it{ should have_selector_h1(user.name)}
      it{ should have_selector_title(user.name)}
      it{ should have_success_message("Welcome to the Sample App!")}
      it{ should have_link('Sign out')}
    end
    
    
    end # end valid information describe block
    
    
    
  end # end sign up describe block
  
  
  describe "edit" do
    let(:user){ FactoryGirl.create(:user) }#code to make a user variable
    
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    #Exercise 6 Chapter 9
    
    #it "should be redirected to root URL in case the user wants to access the new/create actions" do
      
      #visit signup_path # put is used to access the controller action, is the same as visit
      #redirect_to(root_path) 
      
    #end
    
    #before { visit edit_user_path(user)}
  
    describe "page" do
      it{ should have_selector_h1("Update your profile")}
      it{ should have_selector_title("Edit User")}
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end
  
    describe "with invalid information" do
      before { click_button "Save changes" }
    
      it{ should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name){ "New Name" }
      let(:new_email){ "new@example.com" }
      
      before do
      fill_in "Name", with: new_name
      fill_in "Email", with: new_email
      fill_in "Password", with: user.password
      fill_in "Confirm Password", with: user.password
      click_button "Save changes"
      end
      
      it{ should have_selector('title', text: new_name)}
      it{ should have_selector('div.alert.alert-success')}
      it {should have_link('Sign out', href: signout_path)}
      specify {user.reload.name.should == new_name }
      specify {user.reload.email.should == new_email } # this reloads the user variable from the test database using user.reload
      
    end # end valid information
  
  end # end edit describe block
  
  describe "index" do
    
    let(:user){FactoryGirl.create(:user)}
    
    before(:each) do
      sign_in user
      visit users_path   
    #sign_in FactoryGirl.create(:user) 
    #FactoryGirl.create(:user, name:"Bob", email: "bob@example.com") 
    #FactoryGirl.create(:user, name:"Ben", email: "ben@example.com")
    #visit users_path  
   end
   
    it { should have_selector('title', text: "All users") }
    it { should have_selector('h1', text: "All users") }
   
    describe "pagination" do
    
      before(:all){ 30.times { FactoryGirl.create(:user) } }
      after(:all){ User.delete_all }
    
      it { should have_selector('div.pagination')  }
    
        it "should list each user" do
          User.paginate(page: 1).each do |user|
          #User.all.each do |user|
            page.should have_selector('li', text: user.name)
          end
        end
    end #end pagination
    
    describe "delete links" do
    
      it { should_not have_link('delete') }
      
      describe "as an admin user" do
      
          let(:admin){FactoryGirl.create(:admin)}
          before do
            sign_in admin
            visit users_path
          end
          
          it { should have_link('delete', href: user_path(User.first))}
          it "should be able to delete another user" do
            expect { click_link('delete') }.to change(User,:count).by(-1)
          end
          it{should_not have_link('delete', href: user_path(admin))}
      end #end describe as an admin user
      
    end #end describe delete links
   
  end # end index describe
  
end
