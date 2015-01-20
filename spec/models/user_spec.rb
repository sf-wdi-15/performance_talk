require 'rails_helper'

RSpec.describe User, :type => :model do

  ## STRONGLY CONSIDER A REFACTOR INTO USING C.R.U.D. GROUPS

  describe "validate" do

    before(:context) do
      @first_params = {
                        email: "blah@blah.com",
                        email_confirmation: "blah@blah.com",
                        password: "BlahBlah",
                        password_confirmation: "BlahBlah"
                      }
      @first_user = User.create(@first_params)   
    end


    before(:example) do
      @valid_params = {
                        email: "blah2@blah2.com",
                        email_confirmation: "blah2@blah2.com",
                        password: "BlahBlah",
                        password_confirmation: "BlahBlah"
                      }
    end

    after(:example) do
      User.last.destroy()
    end

    describe "email" do 

      it "should always be unique" do
        user = User.new(@first_params)

        expect(user.save).to be(false)

        user = User.create(@valid_params)

        is_updated = user.update_attributes(@first_params)

        expect(is_updated).to be(false)

        user.destroy()
      end

      describe "on create" do

        it "should be present" do
          @valid_params[:email] = @valid_params[:email_confirmation] = nil
          user = User.new(@valid_params)

          expect(user.save).to be(false)
        end

        it "should be confirmed" do
          @valid_params[:email_confirmation] = "notMatching"
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

        it "should enforce presence of email_confirmation" do
          @valid_params[:email_confirmation] = nil
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

        it "should be valid format" do
          @valid_params[:email] = @valid_params[:email_confirmation] = "notValid"
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

      end

      describe "on updates where !email.nil?" do

        before(:example) do
          @valid_params = {
                            email: "blah2@blah2.com",
                            email_confirmation: "blah2@blah2.com",
                            password: "BlahBlah",
                            password_confirmation: "BlahBlah"
                          }
          @valid_user = User.create(@valid_params)
        end

        after(:example) do
          @valid_user.destroy()
        end

        it "should be confirmed" do
          @valid_params[:email_confirmation] = "notMatching"
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

        it "should enforce presence of email_confirmation if :email_changed" do
          @valid_params[:email] = "new@new.com"
          @valid_params[:email_confirmation] = ""
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

        it "should be valid format" do
          @valid_params[:email] = @valid_params[:email_confirmation] = "notValid"
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end
      end

    end

    describe "password" do 

      describe "on create" do

        it "should be present" do
          @valid_params[:password] = @valid_params[:password_confirmation] = nil
          user = User.new(@valid_params)

          expect(user.save).to be(false)
        end

        it "should be confirmed" do
          @valid_params[:password_confirmation] = "notMatching"
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

        it "should enforce presence of password_confirmation" do
          @valid_params[:password_confirmation] = nil
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

        it "should have valid length" do
          @valid_params[:password] = @valid_params[:password_confirmation] = "small"
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

        it "should be valid format" do
          @valid_params[:password] = @valid_params[:password_confirmation] = "poorformat"
          user = User.new(@valid_params)
          
          expect(user.save).to be(false)
        end

      end

      describe "on updates where password.nil?" do


        it "should not require confirmation" do
          valid_params = {
                            email: "blah18@blah18.com",
                            email_confirmation: "blah18@blah18.com",
                            password: "BlahBlah",
                            password_confirmation: "BlahBlah"
                          }
          valid_user = User.create(valid_params)
          valid_user = User.find(valid_user.id)

          expect(valid_user.reload.update!(first_name: "blah")).to be_truthy

        end

      end

      describe "on updates where !password.nil?" do

        before(:example) do
          @valid_params = {
                            email: "blah2@blah2.com",
                            email_confirmation: "blah2@blah2.com",
                            password: "BlahBlah",
                            password_confirmation: "BlahBlah"
                          }
          @valid_user = User.create(@valid_params)
        end

        after(:example) do
          @valid_user.destroy()
        end


        it "should be confirmed" do
          @valid_params[:password_confirmation] = "notMatching"
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

        it "should enforce presence of password_confirmation" do
          @valid_params[:password_confirmation] = nil
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

        it "should have valid length" do
          @valid_params[:password] = @valid_params[:password_confirmation] = "small"
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

        it "should be valid format" do
          @valid_params[:password] = @valid_params[:password_confirmation] = "poorformat"
          is_updated = @valid_user.update_attributes(@valid_params)
          
          expect(is_updated).to be(false)
        end

      end

    end

  end

end
