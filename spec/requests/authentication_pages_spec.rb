require 'spec_helper'

describe "Authentication" do
  
  subject{ page }
  
    describe "signin page" do
      before{ visit signin_path }
    
      it{ should have_selector_h1("Sign in")}
      it{ should have_selector_title("Sign in")}
   
    end #end signing page block
  
    describe "signin" do
      before{ visit signin_path }
      
        describe "with invalid information" do
          before{ click_button "Sign in" }
        
          it{ should have_selector('title', text: 'Sign in') }
          it { should have_error_message('Invalid') }
          #it{ should have_selector('div.alert.alert-error', text:"Invalid") }
          
          describe "after visiting another page" do
            before { click_link "Home" }
            it { should_not have_selector_error }
          end # after visiting another page end block
          
        end #invalid information end block
      
        describe "with valid information" do
        
          let(:user){ FactoryGirl.create(:user)} # first we create a user using the FactoryGirl method, then we use those values to fill in the page fields
          
          before{ sign_in(user) }
          
          it{ should have_selector('title', text: user.name) }
          it{ should have_link('Profile', href: user_path(user)) }
          it{ should have_link('Settings', href: edit_user_path(user)) }
          it{ should have_link('Sign out', href: signout_path) }
          it{ should_not have_link('Sign in', href: signin_path) }
          
          
          #before do
           # fill_in "Email", with: user.email
           # fill_in "Password", with: user.password
           # click_button "Sign in"
          #end
          
          it{ should have_selector_title(user.name)}
          #it{ should have_selector('title', text: user.name) }
          it{ should have_link('Profile', href: user_path(user))}
          it{ should have_link('Sign out', href: signout_path)}
          it{ should_not have_link('Sign in', href: signin_path)} #the second parameter href, is optional
          
          describe "followed by signout" do
            before{ click_link "Sign out" }
            it { should have_link('Sign in') }
          end
        
          
        end #valid information end block
      
    end #signin end block
    
    describe "authorization" do 
    
      describe "for non-signed-in users" do
        let(:user){ FactoryGirl.create(:user) }
      
        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user) # this redirects to the Sign In page
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end
          
          describe "after signing in" do
            
            it "should render the desired protected page" do
              page.should have_selector('title', text: 'Edit User')
            end
          end
          
        end #end of when attempting to visit a protected page
      
        describe "in the Users controller" do
        
          describe "visiting the edit page" do
            before{ visit edit_user_path(user) }
            it { should have_selector('title', text: 'Sign in') }
          end
          
          describe "submitting to the update action" do
            before { put user_path(user) } # put is used to access the controller action, is the same as visit
            specify { response.should redirect_to(signin_path) } # access can be used in this case because the "put" request was used
          end
        
        end # end of in the Users controller
      
      end # end of for non-signed-in users 
      
      describe "as wrong user" do
        let(:user){ FactoryGirl.create(:user) }
        let(:wrong_user){ FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user }
        
        describe "visiting Users#edit page" do
          before { visit edit_user_path(wrong_user) }
          it{ should_not have_selector('title', text: full_title('Edit User')) }
        end
        
        describe "submitting a PUT request to the Users#update action" do
          before{ put user_path(wrong_user) }
          specify { response.should redirect_to(root_path) }
        end
      end #end as wrong user
    
    end #end of authorization block
  
end # end of the Authentication block
