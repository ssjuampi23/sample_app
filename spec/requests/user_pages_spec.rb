require 'spec_helper'

describe "UserPages" do

  subject { page }
    
  describe "signup page" do
    before { visit signup_path } 
    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: full_title('Sign up') ) }   
  end
  
  describe "profile page" do
    let(:user){ FactoryGirl.create(:user) }#code to make a user variable
    before { visit user_path(user)}
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
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
    
      it{ should have_selector('title', text: 'Sign up') }
      it{ should have_content('error')}
      
     it{ should have_content("Password can't be blank")}
     it{ should have_content("Name can't be blank")}
     it{ should have_content("Email can't be blank")}
     it{ should have_content("Email is invalid")}
     it{ should have_content("Password is too short (minimum is 6 characters)")}
     it{ should have_content("Password confirmation can't be blank")}
  
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect{ click_button submit }.to change(User,:count).by(1)
      end
    
      describe "after saving the user" do
    
      before{ click_button submit}
      let(:user){ User.find_by_email('user@example.com') }

      it{ should have_selector('title', text: user.name) }
      it{ should have_selector('h1', text: user.name) }
      it{ should have_selector('div.alert.alert-success', text: "Welcome to the Sample App!")}
      it{ should have_link('Sign out')}
    end
    
    
    end # end valid information describe block
    
    
    
  end # end sign up describe block
  
  
end
