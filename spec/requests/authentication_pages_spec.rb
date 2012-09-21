require 'spec_helper'

describe "Authentication" do
  
  subject{ page }
  
    describe "signin page" do
      before{ visit signin_path }
    
      it{ should have_selector('h1', text:"Sign in")}
      it{ should have_selector('title', text: "Sign in")}
    end #end signing page block
  
    describe "signin" do
      before{ visit signin_path }
      
        describe "with invalid information" do
          before{ click_button "Sign in" }
        
          it{ should have_selector('title', text: 'Sign in') }
          it{ should have_selector('div.alert.alert-error', text:"Invalid") }
          
          describe "after visiting another page" do
            before { click_link "Home" }
            it { should_not have_selector('div.alert.alert-error') }
          end # after visiting another page end block
          
        end #invalid information end block
      
        describe "with valid information" do
        
          let(:user){ FactoryGirl.create(:user)} # first we create a user using the FactoryGirl method, then we use those values to fill in the page fields
          before do
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end
          
          it{ should have_selector('title', text: user.name) }
          it{ should have_link('Profile', href: user_path(user))}
          it{ should have_link('Sign out', href: signout_path)}
          it{ should_not have_link('Sign in', href: signin_path)} #the second parameter href, is optional
          
          describe "followed by signout" do
            before{ click_link "Sign out" }
            it { should have_link('Sign in') }
          end
        
          
        end #valid information end block
      
    end #signin end block
  
end # end of the Authentication block
