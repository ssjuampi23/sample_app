require 'spec_helper'

describe "MicropostPages" do
  
  subject { page }
  
  let(:user){FactoryGirl.create(:user)}
  before { sign_in user }
  
  describe "micropost creation" do
  
    before { visit root_path }
    
    describe "with invalid information" do
    
      it "should not create a micropost" do
        expect{ click_button "Post"}.not_to change(Micropost, :count)
      end 
      
      describe "error messages" do
        before{ click_button "Post"}
        it {should have_content('error')}
      end
    
    end #end invalid information describe
    
    describe "with valid information" do
    
      before{ fill_in 'micropost_content', with:"Lorem ipsum"} #micropost_content is the ID of the text area where the micropost is goint to be written
    
      it "should create a micropost" do
        expect{ click_button "Post"}.to change(Micropost, :count).by(1)
      end
    
    end #end valid information describe
  
  end #end micropost creation describe
  
  describe "micropost destruction" do
    
    before{ FactoryGirl.create(:micropost, user: user) }
  
    describe "as correct user" do
      
      before{ visit root_path } #this visits the home page
      
      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end 
      
    end #end as correct user describe
    
  
  end #end micropost destruction describe
  
end #end MicropostPages describe
