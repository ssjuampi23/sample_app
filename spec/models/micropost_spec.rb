require 'spec_helper'

describe Micropost do
  
  let(:user){ FactoryGirl.create(:user) }
  
  before { @micropost = user.microposts.build(content: "Lorem ipsum") } # this way the micropost user_id is automatically associate with the right value
  #before do
    #this code is wrong!
    #@micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  #end
  
  subject{ @micropost }
  
  it{ should respond_to(:content) } # This code tests that these attributes exist on the database
  it{ should respond_to(:user_id) } # This code tests that these attributes exist on the database
  it{ should respond_to(:user) }
  its(:user){ should == user } 
  
  it{ should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it{ should_not be_valid } #validates :user_id, presence: true on the micropost.rb
  end  
  
  describe "accesible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end
