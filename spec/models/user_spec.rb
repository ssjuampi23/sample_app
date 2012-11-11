# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before do 
    @user = User.new(name: "Juampi", email: "aa@sample.com", password: "foobar", password_confirmation: "foobar") 
  end
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) } # this will assure that the user has the admin privileges to edit and delete other users
  it { should respond_to(:microposts) }
  it { should respond_to(:feed)} # here we are telling to the user model that a variable named feed exists 
  
  it { should be_valid } # it replaces the @user.valid? method from the rails console
  it { should_not be_admin }
  
  describe "with admin attribute set to 'true' " do
    before do
      @user.save!
      @user.toggle!(:admin) #toggle method flips the admin attribute from false to true
    end
    
    it { should be_admin }
  end # end describe admin attribute set to true block
  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do 
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com  user_At_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end 
    end  
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM  user_At_foo-ER@f.b.org example.user@foo.jp a+b@baz.cn]
      
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end 
    end  
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it{ should_not be_valid }
  end
  
 
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end
  
  describe "when password does not match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user){ User.find_by_email(@user.email) }
  
  describe "with valid password" do
    it { should == found_user.authenticate(@user.password) }
  end
  
   describe "with invalid password" do
   let(:user_for_invalid_password) { found_user.authenticate("invalid") }
    
    it { should_not == user_for_invalid_password }
    specify { user_for_invalid_password.should be_false }
   end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  end # end return value of authenticate method
  
  describe "email address with mixed case" do 
    let(:mixed_case_email){ "Foo@ExAMPLE.CoM" }
  
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email
    end
  end
  
  describe "remember token" do
    
    before { @user.save }
    its(:remember_token) { should_not be_blank } #applies the test to the given attribute rather than to the subject of the test
  end
  
  #EXERCISE 1 CHAPTER 9
  
  #in theory if I am testing that the admin attribute should not be accesible, then if I create a new user and then initialize the variable admin, that should display an error
  describe "accesible attributes" do
    it "should not allow access to admin" do
    
      expect do
      
        User.new(admin: true)
        
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

  end #end accesible attributes describe
  
  describe "microposts associations" do
  
    before{ @user.save }
    
    let!(:older_micropost)do # the let! (letbang) makes the variable come to existence immediately
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    
    let!(:newer_micropost)do # the let! (letbang) makes the variable come to existence immediately
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end
    
    it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost,older_micropost]
    end
  
    it "should destroy associated microposts" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty

      #microposts.each do |micropost|
       # Micropost.find_by_id(micropost.id).should be_nil
      #end
      
      
      #lambda.each do |micropost|
      #  Micropost.find(micropost.id)
          
    #  end.should raise_error(ActiveRecord::RecordNotFound)    
     
    end #end should destroy associated microposts
    
    describe "status" do
    
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost,user:FactoryGirl.create(:user))
      end
      
      its(:feed){ should include(newer_micropost) }
      its(:feed){ should include(older_micropost)}
      its(:feed){ should_not include(unfollowed_post)}
    
    end # end status
  
  end #end microposts associations
  
  
end
